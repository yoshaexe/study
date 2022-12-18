//
// [ 2.1.1]
// Выдать упорядоченный список URL ресурсов
//
db.getCollection('main').aggregate([
    {
        $group: {
            _id: "$URL"
        }
    },
    {
        $sort: { _id: 1 }
    }
]);

//
// [2.1.2]
// Выдать упорядоченный список IP-адресов пользователей, посетивших ресурс с заданным URL
//
db.getCollection('main').aggregate([
    {
        $match: { "URL": "https://google.com/" }
    },
    {
        $group: {
            _id: "$IP"
        }
    },
    {
        $sort: { _id: 1 }
    }
]);

//
// [2.1.3]
// Выдать упорядоченный список URL ресурсов, посещенных в заданный временной период
//
db.getCollection('main').aggregate([
    {
        $match: { timeStamp: { $gte: "2022-11-15T16:40:00Z", $lte: "2022-11-15T17:00:00Z" } }
    },
    {
        $group: {
            _id: "$URL"
        }
    },
    {
        $sort: { _id: 1 }
    }
]);

//
// [2.1.4]
// Выдать упорядоченный список URL ресурсов, посещенных пользователем с заданным IP-адресом
//
db.getCollection('main').aggregate([
    {
        $match: { "IP": "252.73.135.153" }
    },
    {
        $group: {
            _id: "$URL"
        }
    },
    {
        $sort: { _id: 1 }
    }
]);

//
// [2.2.1]
// Выдать список URL ресурсов с указанием суммарной длительности посещения каждого ресурса, упорядоченный по убыванию
//
db.getCollection('main').aggregate([
    {
        $group: {
            _id: "$URL",
            SumTimeSpent: { $sum: "$timeSpent" }
        }
    },
    {
        $sort: { "SumTimeSpent": -1 }
    }
]);

//
// [2.2.2]
// Выдать список URL ресурсов с указанием суммарного количества посещений каждого ресурса, упорядоченный по убыванию
//
db.getCollection('main').aggregate([
    {
        $group: {
            _id: "$URL",
            NumberOfVisits: { $sum: 1 }
        }
    },
    {
        $sort: { "NumberOfVisits": -1 }
    }
]);

//
// [2.2.3]
// Выдать список URL ресурсов с указанием количества посещений каждого ресурса в день за заданный период,
// упорядоченный URL ресурса и убыванию количества посещений
//
db.getCollection('main').aggregate([
    {
        $match: {
            timeStamp: { $gte: "2022-01-11T16:40:00Z", $lte: "2022-12-25T17:00:00Z" }
        }
    },
    {
        $addFields: {
            "date": { $toDate: "$timeStamp"}
        }
    },
    {
        $group: {
            _id: {
                URL: "$URL",
                day: { $dayOfMonth: "$date" }
            },
            NumberOfVisits: { $sum: 1 }
        }
    },
    {
        $sort: {
            _id: 1,
            "NumberOfVisits": -1
        }
    }
]);

//
// [2.2.4]
// Выдать список IP-адресов c указанием суммарного количества и суммарной длительности посещений ресурсов,
// упорядоченный по адресу, убыванию количества и убыванию длительности
//
db.getCollection('main').aggregate([
    {
        $group: {
            _id: "$IP",
            SumTimeSpent: { $sum: "$timeSpent" },
            NumberOfVisits: { $sum: 1 }
        }
    },
    {
        $sort: {
            _id: 1,
            "NumberOfVisits": -1,
            "SumTimeSpent": -1
        }
    }
]);