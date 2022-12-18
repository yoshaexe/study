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
CALL gds.graph.project.cypher('graph', 'Place', 'EROAD', {relationshipProperties: 'distance'});

MATCH (n:Place {id: 'London'})
CALL gds.allShortestPaths.delta.stream('graph', {
  sourceNode:                 n,
  delta:                      1.0,
  relationshipWeightProperty: 'distance'
})
YIELD index, sourceNode, targetNode, totalCost, nodeIds, costs, path
  WHERE NOT sourceNode = targetNode
RETURN
  index,
  gds.util.asNode(sourceNode).id AS sourceId,
  gds.util.asNode(targetNode).id AS targetId,
  totalCost,
  [nodeId IN nodeIds | gds.util.asNode(nodeId).id] AS nodeIds,
  costs
  ORDER BY totalCost;

MATCH (n:Place {id: 'London'})
CALL gds.spanningTree.minimum('Place', 'EROAD', 'distance', id(n),
{write: true, writeProperty: 'MINST'})
YIELD loadMillis, computeMillis, writeMillis, effectiveNodeCount
RETURN loadMillis, computeMillis, writeMillis, effectiveNodeCount

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
