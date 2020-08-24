const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();

// https://firebase.google.com/docs/functions/write-firebase-functions
//

exports.getPlanning = functions.region('europe-west1')
.https.onCall(async (data, context) => {
    try {
        return await getPlanningData(context.auth.uid, data.date);
    } catch (error) {
        functions.logger.error('Error getting documents', error, { structuredData: true });
        return {"error": error};
    }
});

async function getPlanningData(uid, date) {
    const planRef = db.collection('plannings').doc(uid).collection(date);
    const snapshot = await planRef.get();
    const plannings = await fetchScheduleRefs(snapshot);
    return { plannings };
}

async function fetchScheduleRefs(planningSnapshot) {

    return Promise.all(planningSnapshot.docs.map(async snap => 
        {
            const planning = snap.data();
            const scheduleRef = planning && planning.schedule_ref;
            if (scheduleRef !== null && scheduleRef !== undefined) {
                const snapshot = await scheduleRef.get();
                planning.schedule = snapshot.data();
                delete planning.schedule_ref;
                await fetchTripRef(planning.schedule);
            }
            return planning;
        })
    );
}

async function fetchTripRef(schedule) {
    const tripRef = schedule && schedule.trip_ref;
    if (tripRef === null || tripRef === undefined) {
        return;
    }
    const snapshot = await tripRef.get();
    schedule.trip = snapshot.data();
    delete schedule.trip_ref;
    await fetchStopRefs(schedule.trip);
}

async function fetchStopRefs(trip) {
    const stopRefs = trip && trip.stops;
    trip.stops = [];
    if (stopRefs === null || stopRefs === undefined) {
        return;
    }
    await Promise.all(stopRefs.map(async stopRef => 
        {
            if (stopRef === null || stopRef === undefined) {
                return;
            }
            const snapshot = await stopRef.get();
            trip.stops.push(snapshot.data());
        })
    );
}