// ### Errors ###############################################################
// s: "hello"
// s: "world" // conflicting values "hello" and "world"

// A: foo: "bar"
// a: A.goo // undefined field A.goo (cue eval -c)

// b: int // incomplete value (cue eval -c)

// l: [1, 2]
// l: [1, 3] // conflicting values 2 and 3

// m: [1, 2]
// v: m[2] // index out of range

// ### Null Coalescing #########################################################
// elems: ["a", "b", "c"]
// a: *elems[0] | "A"
// // out of bounds error
// d: *elems[3] | "D"

// S: {
// 	hello: "world"
// }

// // missing fields
// s: *S.foo | "bar"

// ### Numbers #################################################################
// a: int
// a: 42

// b: number
// b: 3.14

// c: int & 42.0 // conflict int and 42.0

// d: 42   // will be type int
// e: 3.14 // will be type number

// Conflict >>> Bytes

// ### Number Sugar ############################################################
hex:  0xdeadbeef
oct:  0o755
bin:  0b0101_0001
cpu:  0.5Mi
mem:  4Gi
mill: 1M
bill: 1G
zero: 0.0
half: 0.5
trim: 01.23
mole: 6.022_140_76e+23
tiny: 1.2345e-12
long: 23_456_789_000_000000

// ### Strings #################################################################
str:    "hello world"
smile:  "\U0001F60A"
quoted: "you can \"quote by escaping \\ \""
multiline: """
	hello world
	a "quoted string in a string"
	down under
	   - some author
	"""

// ### “Raw” Strings ###########################################################
str1: #"avoid using \ to "escape""#
str2: ##"""
	#"""
	a nested multiline
	string goes here
	"""#
	"""##

// ### Bytes ###################################################################
// b: '\x03abc\U0001F604'

// ### Lists ###################################################################
// empty: []
// any: [...]
// ints: [...int]
// nested: [...[...string]]

// opened: ints & [1, 2, ...]
// closed: ints & [1, 2, 3]

// // list of for constrained ints
// ip: 4 * [uint8]
// // sets the first element
// tendot: ip & [10, ...uint8]
// // uses constraint as second element
// one72: ip & [172, >=16 & <=32, ...]

// mixed: any & [...] & ["a", 1, {foo: "bar"}]
// join:  [1, 2] + [3, 4]
// Join:  opened & join

// ### Structs ###################################################################
// an open struct
a: {
	foo: "bar"
}

// shorthand nested field
a: hello: "world"

// a closed struct
b: close({
	left: "right",
	right: "left",
})

// error, field up not allowed
// b: up: "down"


// ### Definitions #############################################################
// #schema: {
// 	word:      string
// 	num:       int | *42
// 	optional?: string
// }

// value: #schema & {
// 	word: "what's the good?"
// }

// Conflict >>> Pattern Matching Constraints

// ### Embbedings ##############################################################
#A: {
	num: number
}

#B: {
	ans: string
}

// this won't work
// #bad: #A & #B
// bad:  #bad & {
// 	num: 42
// 	ans: "life"
// }

// but this will
#val: {#A, #B}
val: #val & {
	num: 42
	ans: "life"
}

// ### Pattern Matching Constraints ############################################
#schema: {
	name: string
	ans:  string
	num:  int | *42
}

// match elem fields and alias labels to Name,
// unify with schema, set name to Name by label
elems: [Name=_]: #schema & {name: Name}

elems: {
	one: {
		ans: "solo"
		num: 1
	}
	two: {
		ans: "life"
	}
}

elems: other: {ans: "id", num: 23}
