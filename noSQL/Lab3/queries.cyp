// 1.1
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/yoshaexe/study/main/noSQL/Lab3/transport-nodes.csv' AS row
CREATE (place:Place {
  id:         row.id,
  latitude:   toFloat(row.latitude),
  longitude:  toFloat(row.longitude),
  population: toInteger(row.population)
});

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/yoshaexe/study/main/noSQL/Lab3/transport-relationships.csv' AS row
MATCH (origin:Place {id: row.src})
MATCH (destination:Place {id: row.dst})
MERGE (origin)-[:EROAD {distance: toInteger(row.cost)}]->(destination);

// 1.2
MATCH (n)
  WHERE NOT (n)--()
DELETE n;

// 1.3
CALL gds.graph.project(
  'graphPlaces',
  'Place',
  {
    EROAD: {
      properties: 'distance',
      orientation: 'UNDIRECTED'
    }
  }
)

MATCH (n:Place {id: 'London'})
CALL gds.alpha.spanningTree.minimum.write('graphPlaces', {
  startNodeId: id(n),
  relationshipWeightProperty: 'distance',
  writeProperty: 'MINST',
  weightWriteProperty: 'writeCost'
})
YIELD preProcessingMillis, computeMillis, writeMillis, effectiveNodeCount
RETURN preProcessingMillis, computeMillis, writeMillis, effectiveNodeCount;

// 2.1
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/yoshaexe/study/main/noSQL/Lab3/users-nodes.csv' AS row
CREATE (person:Person {
  id:   row.id,
  name: row.name
});

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/yoshaexe/study/main/noSQL/Lab3/messages-nodes.csv' AS row
CREATE (message:Message {
  id:   row.id,
  text: row.text
});

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/yoshaexe/study/main/noSQL/Lab3/users-relationships.csv' AS row
MATCH (source:Person {id: row.src})
MATCH (destination:Person {id: row.dst})
MERGE (source)-[:FOLLOWS {distance: toInteger(row.dist)}]->(destination);

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/yoshaexe/study/main/noSQL/Lab3/messages-relationships.csv' AS row
MATCH (source:Person {id: row.src})
MATCH (destination:Message {id: row.dst})
MERGE (source)-[:FOLLOWS {distance: toInteger(row.dist)}]->(destination);

// 2.2
MATCH (n)
  WHERE NOT (n)--()
DELETE n;

// 2.3
CALL gds.graph.project('usersGraph', 'Person', 'FOLLOWS');

CALL gds.alpha.closeness.harmonic.stream('usersGraph')
YIELD nodeId, centrality
RETURN gds.util.asNode(nodeId).name AS name, centrality
  ORDER BY centrality DESC;
