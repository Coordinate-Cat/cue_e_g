// ### supersets ###############################################################
str: "hello world"
num: 42
flt: 3.14

// Special field name (and a comment)
"k8s.io/annotation": "secure-me"

// lists can have different element types
list: [
	"a", "b", "c",
	1,
	2,
	3,
]

obj: {
	foo: "bar"
	// reuse another field?!
	L: list
}

// ### Types are Values ########################################################
// album: {
// 	title: "Houses of the Holy"
// 	year:  1973
// 	live:  false
// }

// Conflict >>> Defining Fields

// ### Types are Values ########################################################
hello: "world"
hello: "world"

// set a type
s: {a: int}

// set some data
s: {a: 1, b: 2}

// set a nested field without curly braces
s: c: d: 3

// lists must have the same elements
// and cannot change length
l: ["abc", "123"]
l: [
	"abc",
	"123",
]

// ### Defining Fields #########################################################
#Album: {
	artist: string
	title:  string
	year:   int

	// ...  uncomment to open, must be last
}

// This is a conjunction, it says "album" has to be "#Album"
album: #Album & {
	artist: "Led Zeppelin"
	title:  "Led Zeppelin I"
	year:   1969

	// studio: true  (uncomment to trigger error)
}

// ### Conjunctions ############################################################
// conjunctions on a field
n: int & >0 & <100
n: 23

// conjuction of schemas
// val: #Def1 & #Def2
// val: {foo: "bar", ans: 42}

// #Def1: {
// 	foo: string
// 	ans: int
// }

// #Def2: {
// 	foo: =~"[a-z]+"
// 	ans: >0
// }

// Conflict >>> Disjunctions

// ### Disjunctions ############################################################
// disjunction of values (like an enum)
hello: "world" | "bob" | "mary"
hello: "world"

// disjunction of types
port: string | int
port: 5432

// disjunction of schemas
val: #Def1 | #Def2
val: {foo: "bar", ans: 42}

#Def1: {
	foo: string
	ans: int
}

#Def2: {
	name: string
	port: int
}

// ### Defaults and Optionals ##################################################
s: {
	// field with a default
	hello: string | *"world" | "apple"
	// an optional integer
	count?: int
}

// ### Incomplete and Concrete #################################################
// NO CODE
// ### Open and Closed #########################################################
// Closed struct
// s: close({
// 	foo: "bar"
// })

// // Open definition
// #d: {
// 	foo: "bar"
// 	... // must be last
// }

// Confilict >>> Types are Values, Defaults and Optionals

// ### Building Up Values ######################################################
#Base: {
	name: string
	kind: string
}

#Meta: {
	// string and a semver regex
	version: string & =~"^v[0-9]+\\.[0-9]+\\.[0-9]+$"
	// list of strings
	labels: [...string]
}

#Permissions: {
	role:   string
	public: bool | *false
}

// Building up a schema using embeddings
#Schema: {
	// embed other schemas
	#Base
	#Meta

	#Permissions
	// with no '...' this is final
}

value: #Schema & {
	name:    "app"
	kind:    "deploy"
	version: "v1.0.42"
	labels: ["server", "prod"]
	role: "backend"
	// public: false  (by default)
}

// ### Order is Irrelevant #####################################################

