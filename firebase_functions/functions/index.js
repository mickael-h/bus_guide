const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();

// https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.getPlanning = functions.region('europe-west1')
.https.onRequest((request, response) => {
    getPlanningData(request.query)
        .then(data => response.json(data))
        .catch((err) => returnError(err));
});

exports.callableTest = functions.region('europe-west1')
.https.onCall((data, context) => {
    const resp = {
        data,
        context,
    };
    return resp;
});

function returnError(err) {
    functions.logger.error('Error getting documents', err, { structuredData: true });
    return response.status(500).json({ message: "Error getting the planning" + err });
}

async function getPlanningData(query) {
    const planRef = db.collection('plannings').doc(query.uid).collection(query.date);
    const snapshot = await planRef.get();
    const planning = await fetchScheduleRefs(snapshot);
    return { planning };
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