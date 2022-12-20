CREATE
  (valera:Person {
    fio:    'Zhmishenko Valeriy Albertovich',
    gender: 'male',
    age:    28,
    groups: ['VC', 'typical_code', 'beobanka']
  }),
  (max:Person {
    fio:    'Ivanov Max Pavlovich',
    gender: 'male',
    age:    22,
    groups: ['mat_fac', 'beobanka']
  }),
  (maria:Person {
    fio:    'Vodyanskaya Maria Vasylievna',
    gender: 'female',
    age:    20,
    groups: ['lentach', 'beobanka']
  }),
  (mark:Person {
    fio:    'Dripov Mark Yanovich',
    gender: 'male',
    age:    18,
    groups: ['lentach', '2ch', 'typical_code']
  }),
  (michael:Person {
    fio:    'Badyanov Michael Semenovich',
    gender: 'male',
    age:    24,
    groups: ['typical_code', 'alt']
  }),
  (diana:Person {
    fio:    'Zhebk Diana Mamedovna',
    gender: 'female',
    age:    28,
    groups: ['lentach', 'beobanka']
  }),
  (zaur:Person {
    fio:    'Kumanov Zaur Farisovich',
    gender: 'male',
    age:    19,
    groups: ['VC', 'beobanka']
  }),
  (elena:Person {
    fio:    'Babkina Elena Vladimirovna',
    gender: 'female',
    age:    31,
    groups: ['VC', 'lentach', 'hands_and_head']
  }),
  (victoria:Person {
    fio:    'Kokova Victotia Dmitrievna',
    gender: 'female',
    age:    16,
    groups: ['lentach', 'mat_fac']
  }),
  (svetlana:Person {
    fio:    'Nevazhno Svetlana Valerievna',
    gender: 'female',
    age:    24,
    groups: ['red_cardinal', 'mat_fac', 'hands_and_head']
  }),
  (valera)-[:FRIEND]->(max),
  (valera)-[:FRIEND]->(svetlana),
  (svetlana)-[:FRIEND]->(valera),
  (mark)-[:FRIEND]->(elena),
  (maria)-[:FRIEND]->(elena),
  (zaur)-[:FRIEND]->(maria),
  (zaur)-[:FRIEND]->(elena),
  (zaur)-[:FRIEND]->(svetlana),
  (zaur)-[:FRIEND]->(diana),
  (zaur)-[:FRIEND]->(victoria),
  (michael)-[:FRIEND]->(svetlana),
  (svetlana)-[:FRIEND]->(michael),
  (diana)-[:FRIEND]->(elena),
  (victoria)-[:FRIEND]->(michael),
  (victoria)-[:FRIEND]->(max),
  (max)-[:FRIEND]->(valera),
  (svetlana)-[:FRIEND]->(diana),
  (svetlana)-[:FRIEND]->(valera),
  (maria)-[:FRIEND]->(valera),
  (maria)-[:FRIEND]->(zaur)

// 1
// Выдать упорядоченный список ФИО персон
MATCH (p:Person)
RETURN p.fio AS FIO
  ORDER BY p.fio;
// 2
// Выдать список ФИО мужчин с указанием возраста, упорядоченный по убыванию возраста
MATCH (p:Person)
  WHERE p.gender = 'male'
RETURN p.fio AS FIO, p.age AS AGE
  ORDER BY p.age DESC;
// 3
// Выдать упорядоченный список ФИО друзей персоны заданными ФИО
MATCH (:Person {fio: 'Zhmishenko Valeriy Albertovich'})-[:FRIEND]->(n)
RETURN n.fio AS FIO
  ORDER BY n.fio;
// 4
// Выдать упорядоченный список ФИО друзей друзей персоны заданными ФИО
MATCH (p:Person {fio: 'Zhmishenko Valeriy Albertovich'})-[:FRIEND *2]->(n)
  WHERE NOT (p)-[:FRIEND]->(n) AND NOT (n) = (p)
RETURN DISTINCT n.fio AS FIO
  ORDER BY n.fio;
// 5
// Выдать упорядоченный по алфавиту список ФИО персон, в котором для каждой персоны указано количество друзей
MATCH (p:Person)-[:FRIEND]->(n)
RETURN DISTINCT p.fio AS FIO, count(n) AS NUMBER_OF_FRIENDS
  ORDER BY p.fio;
// 6
// Выдать упорядоченный список групп социальной сети
MATCH (p:Person)
UNWIND p.groups AS group
RETURN DISTINCT group AS GROUP
  ORDER BY group;
// 7
// Выдать упорядоченный список групп персоны с заданными ФИО
MATCH (p:Person {fio: 'Zhmishenko Valeriy Albertovich'})
UNWIND p.groups AS group
RETURN DISTINCT group AS Group
  ORDER BY group;
// 8
// Выдать список групп социальной сети с указанием количества членов каждой группы,
// упорядоченный по убыванию количества членов группы
MATCH (p:Person)
UNWIND p.groups AS group
RETURN DISTINCT group AS Group, count(group) AS NUMBER_OF_MEMBERS
  ORDER BY NUMBER_OF_MEMBERS DESC;
// 9
// Выдать список ФИО персон, в котором для каждой персоны указано количество групп,
// в которые она входит, упорядоченный по убыванию количества групп
MATCH (p:Person)
RETURN DISTINCT p.fio AS FIO, size(p.groups) AS NUMBER_OF_GROUPS
  ORDER BY NUMBER_OF_GROUPS DESC;
// 10
// Выдать общее количество групп, в которых состоят друзья друзей персоны с заданными ФИО
MATCH (p:Person {fio: 'Nevazhno Svetlana Valerievna'})-[:FRIEND *2]->(n)
  WHERE NOT (p)-[:FRIEND]->(n) AND NOT (n) = (p)
RETURN DISTINCT n.fio AS FIO, size(n.groups) AS NUMBER_OF_GROUPS
  ORDER BY NUMBER_OF_GROUPS DESC;

// TASK | №2
CREATE
  (valera:Person {
    fio:    'Zhmishenko Valeriy Albertovich',
    gender: 'male',
    age:    28
  }),
  (max:Person {
    fio:    'Ivanov Max Pavlovich',
    gender: 'male',
    age:    22
  }),
  (maria:Person {
    fio:    'Vodyanskaya Maria Vasylievna',
    gender: 'female',
    age:    20
  }),
  (mark:Person {
    fio:    'Dripov Mark Yanovich',
    gender: 'male',
    age:    18
  }),
  (michael:Person {
    fio:    'Badyanov Michael Semenovich',
    gender: 'male',
    age:    24
  }),
  (diana:Person {
    fio:    'Zhebk Diana Mamedovna',
    gender: 'female',
    age:    28
  }),
  (zaur:Person {
    fio:    'Kumanov Zaur Farisovich',
    gender: 'male',
    age:    19
  }),
  (elena:Person {
    fio:    'Babkina Elena Vladimirovna',
    gender: 'female',
    age:    31
  }),
  (victoria:Person {
    fio:    'Kokova Victotia Dmitrievna',
    gender: 'female',
    age:    16
  }),
  (svetlana:Person {
    fio:    'Nevazhno Svetlana Valerievna',
    gender: 'female',
    age:    24
  }),
  (vc:Group {name: 'VC'}),
  (tc:Group {name: 'typical_code'}),
  (beob:Group {name: 'beobanka'}),
  (mf:Group {name: 'mat_fac'}),
  (lentach:Group {name: 'lentach'}),
  (dvach:Group {name: '2ch'}),
  (alt:Group {name: 'alt'}),
  (hnh:Group {name: 'hands_and_head'}),
  (rc:Group {name: 'red_cardinal'}),
  (valera)-[:FOLLOWS]->(vc),
  (valera)-[:FOLLOWS]->(tc),
  (valera)-[:FOLLOWS]->(beob),
  (max)-[:FOLLOWS]->(mf),
  (max)-[:FOLLOWS]->(beob),
  (maria)-[:FOLLOWS]->(lentach),
  (maria)-[:FOLLOWS]->(beob),
  (mark)-[:FOLLOWS]->(lentach),
  (mark)-[:FOLLOWS]->(dvach),
  (mark)-[:FOLLOWS]->(tc),
  (michael)-[:FOLLOWS]->(tc),
  (michael)-[:FOLLOWS]->(alt),
  (diana)-[:FOLLOWS]->(lentach),
  (diana)-[:FOLLOWS]->(beob),
  (zaur)-[:FOLLOWS]->(vc),
  (zaur)-[:FOLLOWS]->(beob),
  (elena)-[:FOLLOWS]->(vc),
  (elena)-[:FOLLOWS]->(lentach),
  (elena)-[:FOLLOWS]->(hnh),
  (victoria)-[:FOLLOWS]->(lentach),
  (victoria)-[:FOLLOWS]->(mf),
  (svetlana)-[:FOLLOWS]->(rc),
  (svetlana)-[:FOLLOWS]->(mf),
  (svetlana)-[:FOLLOWS]->(hnh),
  (valera)-[:FRIEND]->(max),
  (valera)-[:FRIEND]->(svetlana),
  (svetlana)-[:FRIEND]->(valera),
  (mark)-[:FRIEND]->(elena),
  (maria)-[:FRIEND]->(elena),
  (zaur)-[:FRIEND]->(maria),
  (zaur)-[:FRIEND]->(elena),
  (zaur)-[:FRIEND]->(svetlana),
  (zaur)-[:FRIEND]->(diana),
  (zaur)-[:FRIEND]->(victoria),
  (michael)-[:FRIEND]->(svetlana),
  (svetlana)-[:FRIEND]->(michael),
  (diana)-[:FRIEND]->(elena),
  (victoria)-[:FRIEND]->(michael),
  (victoria)-[:FRIEND]->(max),
  (max)-[:FRIEND]->(valera),
  (svetlana)-[:FRIEND]->(diana),
  (svetlana)-[:FRIEND]->(valera),
  (maria)-[:FRIEND]->(valera),
  (maria)-[:FRIEND]->(zaur)

CREATE
  (p1:Post {
    id:   1,
    text: 'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...'
  }),
  (p2:Post {
    id:   2,
    text: 'Praesent vitae porta neque. Maecenas eget mattis dolor. Praesent gravida, ante in laoreet dictum, neque lorem iaculis nibh, vel egestas leo risus a lectus.'
  }),
  (p3:Post {
    id:   3,
    text: 'Suspendisse ut nisl nec metus dignissim pellentesque. Duis cursus dolor mi, at euismod orci consequat.'
  }),
  (p4:Post {
    id:   4,
    text: 'Integer quis quam id sem efficitur bibendum nec nec leo. Nam ac nulla id sem ornare interdum.'
  }),
  (p5:Post {
    id:   5,
    text: 'Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nunc diam dui, varius ac purus ut.'
  }),
  (p6:Post {
    id:   6,
    text: 'Morbi tempus erat quis dignissim viverra. Aenean quis nisl ante. Fusce id nulla sit.'
  }),
  (p7:Post {
    id:   7,
    text: 'Morbi tempus erat quis dignissim viverra. Aenean quis nisl ante. Fusce id nulla sit.'
  }),
  (p8:Post {
    id:   8,
    text: 'Morbi tempus erat quis dignissim viverra. Aenean quis nisl ante. Fusce id nulla sit.'
  }),
  (p9:Post {
    id:   9,
    text: 'Morbi tempus erat quis dignissim viverra. Aenean quis nisl ante. Fusce id nulla sit.'
  }),
  (p10:Post {
    id:   10,
    text: 'Duis lacinia lorem eget velit pretium aliquam. Morbi consectetur pulvinar nisi sed.'
  }),
  (p11:Post {
    id:   11,
    text: 'Integer sodales tempus augue quis rhoncus. Aenean feugiat dolor sapien.'
  });

// reposted two popular posts
MATCH (h1:Person {fio: 'Zhmishenko Valeriy Albertovich'})
MATCH (p1:Post {id: 1})
MATCH (p3:Post {id: 3})
MATCH (p5:Post {id: 5})
CREATE (h1)-[:CREATES]->(p1)
CREATE (h1)-[:LIKES]->(p3)
CREATE (h1)-[:LIKES]->(p5)
CREATE (h1)-[:REPOST]->(p3)
CREATE (h1)-[:REPOST]->(p5);
// reposted two popular posts
MATCH (h2:Person {fio: 'Ivanov Max Pavlovich'})
MATCH (p2:Post {id: 2})
MATCH (p3:Post {id: 3})
MATCH (p4:Post {id: 4})
MATCH (p5:Post {id: 5})
CREATE (h2)-[:CREATES]->(p2)
CREATE (h2)-[:REPOST]->(p3)
CREATE (h2)-[:LIKES]->(p3)
CREATE (h2)-[:LIKES]->(p4)
CREATE (h2)-[:REPOST]->(p5);

MATCH (h3:Person {fio: 'Vodyanskaya Maria Vasylievna'})
MATCH (p2:Post {id: 2})
MATCH (p3:Post {id: 3})
MATCH (p5:Post {id: 5})
CREATE (h3)-[:CREATES]->(p3)
CREATE (h3)-[:LIKES]->(p2)
CREATE (h3)-[:LIKES]->(p5)
CREATE (h3)-[:REPOST]->(p5);

MATCH (h4:Person {fio: 'Noname Miron Yanovich'})
MATCH (p2:Post {id: 2})
MATCH (p4:Post {id: 4})
MATCH (p5:Post {id: 5})
MATCH (p7:Post {id: 7})
CREATE (h4)-[:CREATES]->(p4)
CREATE (h4)-[:LIKES]->(p2)
CREATE (h4)-[:LIKES]->(p5)
CREATE (h4)-[:LIKES]->(p7)
CREATE (h4)-[:REPOST]->(p5)
CREATE (h4)-[:REPOST]->(p2);
// reposted two popular posts
MATCH (h5:Person {fio: 'Dripov Mark Yanovich'})
MATCH (p2:Post {id: 2})
MATCH (p3:Post {id: 3})
MATCH (p5:Post {id: 5})
CREATE (h5)-[:CREATES]->(p5)
CREATE (h5)-[:LIKES]->(p2)
CREATE (h5)-[:LIKES]->(p3)
CREATE (h5)-[:REPOST]->(p5)
CREATE (h5)-[:REPOST]->(p3);

MATCH (h6:Person {fio: 'Badyanov Michael Semenovich'})
MATCH (p2:Post {id: 2})
MATCH (p5:Post {id: 5})
MATCH (p6:Post {id: 6})
CREATE (h6)-[:CREATES]->(p6)
CREATE (h6)-[:LIKES]->(p2)
CREATE (h6)-[:LIKES]->(p5)
CREATE (h6)-[:REPOST]->(p2);

MATCH (h7:Person {fio: 'Zhebk Diana Mamedovna'})
MATCH (p5:Post {id: 5})
MATCH (p7:Post {id: 7})
CREATE (h7)-[:CREATES]->(p7)
CREATE (h7)-[:LIKES]->(p5)
CREATE (h7)-[:REPOST]->(p5);

MATCH (h8:Person {fio: 'Kumanov Zaur Farisovich'})
MATCH (p6:Post {id: 6})
MATCH (p8:Post {id: 8})
MATCH (p11:Post {id: 11})
CREATE (h8)-[:CREATES]->(p8)
CREATE (h8)-[:LIKES]->(p11)
CREATE (h8)-[:REPOST]->(p6);

MATCH (h9:Person {fio: 'Babkina Elena Vladimirovna'})
MATCH (p1:Post {id: 1})
MATCH (p3:Post {id: 3})
MATCH (p5:Post {id: 5})
MATCH (p9:Post {id: 9})
CREATE (h9)-[:CREATES]->(p9)
CREATE (h9)-[:LIKES]->(p3)
CREATE (h9)-[:LIKES]->(p5)
CREATE (h9)-[:REPOST]->(p1);

MATCH (h10:Person {fio: 'Kokova Victotia Dmitrievna'})
MATCH (p5:Post {id: 5})
MATCH (p6:Post {id: 6})
MATCH (p9:Post {id: 9})
MATCH (p10:Post {id: 10})
CREATE (h10)-[:CREATES]->(p10)
CREATE (h10)-[:LIKES]->(p5)
CREATE (h10)-[:LIKES]->(p9)
CREATE (h10)-[:REPOST]->(p6);
// reposted two popular posts
MATCH (h11:Person {fio: 'Nevazhno Svetlana Valerievna'})
MATCH (p3:Post {id: 3})
MATCH (p5:Post {id: 5})
MATCH (p11:Post {id: 11})
CREATE (h11)-[:CREATES]->(p11)
CREATE (h11)-[:LIKES]->(p5)
CREATE (h11)-[:LIKES]->(p3)
CREATE (h11)-[:REPOST]->(p5)
CREATE (h11)-[:REPOST]->(p3);

// Вывести список людей, которые сделали репост всех двух самых популярных записей (по количеству лайков)

// right solution
MATCH (post:Post)<-[L:LIKES]-(Person)
WITH post, count(L) AS postLikes
ORDER BY postLikes DESC
LIMIT 2
MATCH (person:Person)-[:REPOST]->(post)
WITH DISTINCT person.fio AS Person, post.id AS ID
WITH Person, count(Person) AS NUM
WHERE NUM = 2
RETURN Person;
