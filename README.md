Introduction
============

This project is a bank simulator that is build on top of [node.js](http://nodejs.org).

Installation
============
On Ubuntu, clone this repository then run the install script.
```
./install
```

Run
===
You should make sure that mongo is running:
```
mongod
```

Next, use the run script:
```
./run
```

Finally, visit ```http://127.0.0.1:5000/``` and test the application.

Documentation
=============
Commented source code is available under ```docs/docco```. To access it, open ```docs/docco/server.html``` inside your browser.

If you which to generate yourself documentation, first install coffescript:
```
npm install coffee-script docco codo
```

Then run:
```
cake docs
```
