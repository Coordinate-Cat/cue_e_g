// ### Mathematical Operations #################################################
// mathematical!
n1: 3 + 2
n2: 3 - 2
n3: 3 * 2
n4: 3 / 2

// Truncated division
q: quo(-5, 2)
r: rem(-5, 2)
// Euclidean division
d: div(-5, 2)
m: mod(-5, 2)

// math on strings and lists
// s: 3*"for he's a jolly good fellow\n" + "which nobody can deny"

// Conflict >>> Interpolation

l: 5 * ["eye"]

// ### Comparison Operations ###################################################
// // number constraints
// positive:  >0 // numbers
// doubledig: >=10 & <100 & int

// // lexical comparison
// lowercase: >="a" & <="z"

// notone: <1 | >1
// notone: 1 // error, empty disjuntion

// ### Regular Expressions #####################################################
// a: "hello world" & =~"^hello [a-z]+$"
// b: "hello" & !~"^[A-Z]+"

// lowercase: =~"^[a-z]+$"

// c: "hello" & lowercase
// d: "Hello" & lowercase // error

// ### Interpolation ###########################################################
container: {
	repo:    "docker.io/cuelang"
	image:   "cue"
	version: "v0.3.0"
	full:    "\(repo)/\(image):\(version)"
}

name: "Tony"
msg:  "Hello \(name)"
// conver string to bytes
b: '\(msg)'
// convert bytes to string
s: "\(b)"

// ### List Comprehensions #####################################################
nums: [1, 2, 3, 4, 5, 6]
sqrd: [ for _, n in nums {n * n}]
even: [ for _, n in nums if mod(n, 2) == 0 {n}]

listOfStructs: [ for p, n in nums {
	pos: p
	val: n
}]

extractVals: [ for p, S in listOfStructs {S.val}]

// ### Field Comprehensions ####################################################
apps: ["nginx", "express", "postgres"]
#labels: [string]: string
stack: {
	for i, app in apps {
		"\(app)": {
			name:   app
			labels: #labels & {
				app:  "foo"
				tier: "\(i)"
			}
		}
	}
}

// ### Conditional Fields ######################################################
// app: {
// 	name: string
// 	tech: string
// 	mem:  int

// 	if tech == "react" {
// 		tier: "frontend"
// 	}
// 	if tech != "react" {
// 		tier: "backend"
// 	}

// 	if mem < 1Gi {
// 		footprint: "small"
// 	}
// 	if mem >= 1Gi && mem < 4Gi {
// 		footprint: "medium"
// 	}
// 	if mem >= 4Gi {
// 		footprint: "large"
// 	}
// }
