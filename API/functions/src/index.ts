import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as firebaseHelper from "firebase-functions-helper";
import * as express from "express";
import * as bodyParser from "body-parser";
admin.initializeApp(functions.config().firebase);
// const db = admin.firestore();
const app = express();
const main = express();
main.use("/api/v1", app);
main.use(bodyParser.json());
main.use(bodyParser.urlencoded({extended: false}));

export const webApi = functions.https.onRequest(main);

// // Add new contact
// app.post("/contacts", async (req, res) => {
//     try {
//         const contact: Contact = {
//             firstName: req.body["firstName"],
//             lastName: req.body["lastName"],
//             email: req.body["email"]
//         }
// const newDoc = await firebaseHelper.firestore
//             .createNewDocument(db, contactsCollection, contact);
//         res.status(201).send(`Created a new contact: ${newDoc.id}`);
//     } catch (error) {
//         res.status(400)
//            .send("invalid format")
//     }
// })
// // Update new contact
// app.patch("/contacts/:contactId", async (req, res) => {
//     const updatedDoc = await firebaseHelper.firestore
//         .updateDocument(
//            db,
//            contactsCollection,
//            req.params.contactId,
//            req.body
//          );
//     res.status(204).send(`Update a new contact: ${updatedDoc}`);
// })


// * request schedule
app.get("/schedule/:deviceId", (req, res) => {
  firebaseHelper.firestoreHelper
      .backup("schedule")
      .then((doc) => res.status(200).send(doc))
      .catch((error) => res.status(400).send("Cannot get schedule: ${error}"));
});


// // View all contacts
// app.get("/contacts", (req, res) => {
//     firebaseHelper.firestore
//         .backup(db, contactsCollection)
//         .then(data => res.status(200).send(data))
//         .catch(error =>
//            res.status(400).send(`Cannot get contacts: ${error}`));
// })
// // Delete a contact
// app.delete("/contacts/:contactId", async (req, res) => {
//     const deletedContact = await firebaseHelper.firestore
//         .deleteDocument(db, contactsCollection, req.params.contactId);
//     res.status(204).send(`Contact is deleted: ${deletedContact}`);
// })
