import Firebase from 'firebase'

config =
  apiKey: "AIzaSyC8Zeg4D3--0gijNgS84_Vg997hIcTCB60"
  authDomain: "killteams-998ee.firebaseapp.com"
  databaseURL: "https://killteams-998ee.firebaseio.com"
  projectId: "killteams-998ee"
  storageBucket: "killteams-998ee.appspot.com"
  messagingSenderId: "273908755034"

firebaseApp = Firebase.initializeApp config
firebaseDatabase = firebaseApp.database()

export default { database: firebaseDatabase }
