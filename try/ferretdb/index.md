---
x: FerretDB
title: Try FerretDB in Y minutes
image: /try/cover.png
lastmod: 2023-10-23
canonical: https://blog.ferretdb.io/mongodb-crud-operations-with-ferretdb/
original: https://blog.ferretdb.io/mongodb-crud-operations-with-ferretdb/
license: CC-BY-SA-4.0
contributors:
    - ["Alexander Fashakin", "https://github.com/fashander"]
    - ["Anton Zhiyanov", "https://antonz.org"]
---

[FerretDB](https://www.ferretdb.io/) is an open-source drop-in replacement for MongoDB that uses PostgreSQL or SQLite as a backend. With FerretDB, there's no need to learn new syntax or query methods. You can use the familiar MongoDB query language or driver API.

This guide will show you how to perform basic MongoDB CRUD operations using FerretDB.

[CRUD operations](#crud-operations) ·
[Database](#create-a-database) ·
[Create](#create-operation) ·
[Read](#read-operation) ·
[Update](#update-operation) ·
[Delete](#delete-operation) ·
[Further reading](#further-reading)

<div class="tryx__panel">
<p>✨ <strong>This guide needs some love</strong></p>
<p>The guide only covers the basic FerretDB operations. It would be great to add more features. If you'd like to help — please <a href="https://github.com/nalgeon/tryxinyminutes/blob/main/try/ferretdb/index.md">contribute</a>!</p>
</div>

## CRUD operations

CRUD (Create, Read, Update, and Delete) operations are at the heart of any database management system.
They allow users to easily interact with the database to create, sort, filter, modify, or delete records.

For users looking for an open-source MongoDB alternative, FerretDB offers a direct replacement that still allows you to use all your favorite MongoDB CRUD methods and commands, without having to learn entirely new commands.

## Database

As with MongoDB, you can view the list of databases in FerretDB using the `show dbs` command. The `use` command allows you to switch from one database to another. If the database does not exist, FerretDB will create a new one:

```js
use league
```

<codapi-snippet sandbox="ferretdb" editor="basic">
</codapi-snippet>

Since there is no existing database with this name, a new database (`league`) is created in your FerretDB storage backend (PostgreSQL or SQLite depending on your configuration).

## Create operation

Similar to MongoDB, FerretDB provides the `insertOne()` and `insertMany()` methods for adding new records to a collection.

### insertOne()

Using the database we created earlier, let's insert a single document record with fields and values into the collection by calling the `insertOne()` method. The syntax for this operation is as follows:

```js
db.collection_name.insertOne({field1: value1, field2: value2, ...fieldN: valueN})
```

The process is identical to adding a single data record in MongoDB. Let's start by adding a single team to the league:

```js
db.league.insertOne({
    club: "PSG",
    points: 30,
    average_age: 30,
    discipline: { red: 5, yellow: 30 },
    qualified: false,
});
```

<codapi-snippet id="insert-1.js" sandbox="ferretdb" editor="basic">
</codapi-snippet>

This command creates a new document in the collection. If the operation is successful, you'll get a response with `acknowledged` equal to `true`, and the ID of the inserted document (`insertedID`) containing the ObjectId.

Note that if a collection does not exist, the insert command will automatically create one for you.

### insertMany()

Instead of creating just a single document in the collection, you can create multiple documents using the `insertMany()` method. Indicate that you are inserting multiple document records with square brackets, and separate each document with commas:

```js
db.collection_name.insertMany([{ document1 }, { document2 }, ...{ documentN }]);
```

To see how this works, let's add three more teams to the league:

```js
db.league.insertMany([
    {
        club: "Arsenal",
        points: 80,
        average_age: 24,
        discipline: { red: 2, yellow: 15 },
        qualified: true,
    },
    {
        club: "Barcelona",
        points: 60,
        average_age: 31,
        discipline: { red: 0, yellow: 7 },
        qualified: false,
    },
    {
        club: "Bayern",
        points: 84,
        average_age: 29,
        discipline: { red: 1, yellow: 20 },
        qualified: true,
    },
]);
```

<codapi-snippet id="insert-2.js" sandbox="ferretdb" editor="basic" depends-on="insert-1.js">
</codapi-snippet>

Now we have 4 teams in the league: _Arsenal_, _Barcelona_, _Bayern_ and _PSG_.

## Read operation

Read operations in FerretDB are similar to those in MongoDB. We'll explore two basic methods for querying records in a collection: `find()` and `findOne()`.

### find()

In each read operation, you must filter the documents according to some criteria. The `find()` method filters and selects all the documents in a collection that match the query parameters.

First, let's select all the teams in the league:

```js
db.league.find({});
```

<codapi-snippet sandbox="ferretdb" editor="basic" depends-on="insert-2.js">
</codapi-snippet>

With an empty query parameter, the method returns all documents in the `league` collection.

Now, let's add a query parameter to the `find()` operation to filter for a specific team:

```js
db.league.find({ club: "PSG" });
```

<codapi-snippet sandbox="ferretdb" editor="basic" depends-on="insert-2.js">
</codapi-snippet>

You can also filter a collection in FerretDB using any of the common MongoDB operators:

-   `$eq`: select records that are equal to a specific value
-   `$ne`: not equal to a specific value
-   `$gt`: greater than a specific value
-   `$lt`: less than a specific value
-   `$gte`: greater or equal to a specific value
-   `$lte`: less than or equal to a specific value
-   `$in`: records that contain any of the values in a given array
-   `$nin`: records that do not contain any of the values in a given array

#### Find documents using the `$in` operator

Suppose we want to query the collection for documents that contain any of the values present in an array. To do this, we'll filter the document using an array of values with the `$in` operator:

```js
db.collection_name.find({ field: { $in: [<value1>, <value2>, ... <valueN> ] } })
```

Let's filter the `league` data for teams with 80 or 60 `points`:

```js
db.league.find({ points: { $in: [80, 60] } });
```

<codapi-snippet sandbox="ferretdb" editor="basic" depends-on="insert-2.js">
</codapi-snippet>

That would be _Arsenal_ and _Barcelona_.

#### Find documents using the `$lt` operator

The `$lt` operator filters a collection for records that are less than a specified value. For example, let's select the documents with less than 60 `points`:

```js
db.league.find({ points: { $lt: 60 } });
```

<codapi-snippet sandbox="ferretdb" editor="basic" depends-on="insert-2.js">
</codapi-snippet>

It seems that _PSG_ is not doing so well.

### findOne()

The `findOne()` method selects the first document that matches a given set of query parameters. For example, let's filter by qualified teams:

```js
db.league.findOne({ qualified: true });
```

<codapi-snippet sandbox="ferretdb" editor="basic" depends-on="insert-2.js">
</codapi-snippet>

Even though two documents match this query (_Arsenal_ and _Bayern_), `findOne` only returns the first one (_Arsenal_).

## Update operation

Update operations are write commands that accept a query parameter and changes to be applied to a document.

We will explore three basic MongoDB methods for updating documents using FerretDB: `updateOne()`, `updateMany()`, and `replaceOne()`.

### updateOne()

The `updateOne()` method uses a query parameter to filter and then update a single document in a collection. The following syntax represents the update operation, where the atomic operator `$set` contains the new record:

```js
db.collection_name.updateOne({<query-params>}, {$set: {<update fields>}})
```

Let's increase the number of points for the _PSG_ team to 35 (not that it helps, honestly):

```js
db.league.updateOne({ club: "PSG" }, { $set: { points: 35 } });
```

<codapi-snippet id="update-1.js" sandbox="ferretdb" editor="basic" depends-on="insert-2.js">
</codapi-snippet>

This update operation only affects the first document that's retrieved from the collection. If the operation is successful, the queried document is updated (`modifiedCount` equals to 1).

### updateMany()

The `updateMany()` method can take a query and update many documents at once. For example, let's treat all teams with less than 90 points as not qualified:

```js
db.league.updateMany({ points: { $lte: 90 } }, { $set: { qualified: false } });
```

<codapi-snippet id="update-2.js" sandbox="ferretdb" editor="basic" depends-on="update-1.js">
</codapi-snippet>

According to the `matchedCount` = 4, the filtering part of the command selected all our teams. And since `modifiedCount` = 2, the only two previously qualified teams (_Arsenal_ and _Bayern_) are no longer qualified. This leaves us with no qualified teams at all.

### replaceOne()

The `replaceOne()` method is ideal if you intend to replace an entire document at once.

```js
db.league.replaceOne(
    { club: "Barcelona" },
    {
        club: "Inter",
        points: 83,
        average_age: 32,
        discipline: { red: 2, yellow: 10 },
        qualified: true,
    }
);
```

<codapi-snippet id="update-3.js" sandbox="ferretdb" editor="basic" depends-on="update-2.js">
</codapi-snippet>

_Inter_ replaces _Barcelona_...

```js
db.league.find({ qualified: true });
```

<codapi-snippet sandbox="ferretdb" editor="basic" depends-on="update-3.js">
</codapi-snippet>

... and becomes the only qualified team in the league.

## Delete operation

The delete operations only affect a single collection. Let's look at two methods for deleting documents: `deleteOne()` and `deleteMany()`.

### deleteOne()

The `deleteOne()` method takes in a query parameter that filters a collection for a particular document and then deletes it.

Let's get rid of _Arsenal_:

```js
db.league.deleteOne({ club: "Arsenal" });
```

<codapi-snippet id="delete-1.js" sandbox="ferretdb" editor="basic" depends-on="update-3.js">
</codapi-snippet>

Note that this operation deletes only the first document that matches the query.

### deleteMany()

The `deleteMany()` method is used to delete multiple documents in a collection. The operation takes a query, then filters and deletes all documents that match the query.

Let's remove all non-qualifying teams from the league:

```js
db.league.deleteMany({ qualified: false });
```

<codapi-snippet id="delete-2.js" sandbox="ferretdb" editor="basic" depends-on="delete-1.js">
</codapi-snippet>

Two more teams are deleted. Where does that leave us? Let's find out:

```js
db.league.find({});
```

<codapi-snippet sandbox="ferretdb" editor="basic" depends-on="delete-2.js">
</codapi-snippet>

So the only one left is _Inter_. Good for them!

## Further reading

Beyond the basic CRUD operations covered in this post, you can perform more complex MongoDB commands. See FerretDB [documentation](https://docs.ferretdb.io/) for details.
