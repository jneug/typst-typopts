//#import "@local/mantys:0.0.1": *
#import "../mantys-0.0.1/mantys.typ": *

#import "options.typ"

#show: mantys.with(
	name:		"typopts",
	title: 		"The typopts Package",
	subtitle: 	[#strong("Typ")st #strong("opt")ion#strong("s") management],
	info:		[A *Typst* package to conveniently handle options and arguments.],
	authors:	"Jonas Neugebauer",
	url:		"https://github.com/jneug/typst-typopts",
	version:	"0.0.4",
	date:		"2023-07-05",
	abstract: 	[
		#pkg[typopts] is a *Typst* package with the intend to make handling options for packages and templates as easy as possible.

		It provides functionality to load options from various sources, merge them together and make them accessible throughout the document.
	]
)

#let ns = mty.rawi

= About

TYPOPTS was inspired by _LaTeX_ packages like #mty.rawi[pgfkeys]#footnote[https://ctan.org/pkg/pgfkeys] and modules like #mty.rawi[argparse]#footnote[https://docs.python.org/3/library/argparse.html] in _Python_.

= Usage

== Use as a module

To use TYPOPTS as a module for one project, get the file `options.typ` from the repository and save it in your project folder.

Import the module as usual:
#sourcecode[
```typc
#import "options.typ"
```
]

To use the `state` module do the same with the file `states.typ`:
#sourcecode[
```typc
#import "states.typ"
```
]

== Use as a package

Currently the package needs to be installed into the local package repository.

Either download the current release from GitHub#footnote[#link("https://github.com/jneug/typst-typopts/releases/latest")] and unpack the archive into yout system dependent local repository folder or clone it directly:

#shell(title:"cmd")[
```shell-unix-generic
git clone https://github.com/jneug/typst-typopts.git typopts-0.0.4
```
]

In either case make sure the files are placed in a folder with the correct version number: `typopts-0.0.4`

After installing the package just import it inside your `typ` file:

#sourcecode[
```typc
#import "@local/typopts:0.0.4": options
```
]

== Available functions

TYPOPTS provides several commands in three categories: Options access, argument parsing and configuration loading.

=== Accessing options

Options are simply key/value-pairs that are stored in a global state variable. This allows them to be access anywhere, even outside a main template function.

#idx(term:"Namespace")[Namespaces] are a way to create logical groups of options. All commands handling options accept an #arg[ns] argument to specify the namespace. Alternatively the namespace may be defined in dot-notation with thr option name.

`#options.get("colors.red")` and `#options.get("red", ns:"colors")` will both retrieve the option #opt-[red] from the namespace #ns[colors]. The argument takes precedence though and will prevent any namespaces before a dot to take effect. This means `#options.get("colors.red", ns:"colors")` will look for an option #opt-[colors.red] in the namespace #ns[colors].

#command("get", ..args("name", "func", default:none, ns:none, final:false, loc:none))[
	#argument("name", type:"string")[
		Name of the option.
	]
	#argument("func", type:"any => none")[
		Function to pass the value to.
	]
	#argument("default", type:"any", default:none)[
		Default value, if an option #arg("name") does not exist.
	]
	#argument("final", type:"boolean", default:false)[
		If set to #value(true), the options final value is retrieved, otherwise the local value.
	]
	#argument("loc", type:"location", default:none)[
		A #dtype("location") to use for retrieving the value.
	]
	#argument("ns", type:"string", default:none)[
		The namespace to look for the value in.
	]

	Retrieves the value for the option by the given #arg("name") and passes it to #arg("func"), which is a function of one argument.

	If no option #arg("name") exists, the given #arg("default") is passed on.

	If #arg(final: true), the final value for the option is retrieved, otherwise the current value. If #arg("loc") is given, the call is not wrapped inside a #doc("meta/locate") call and the given #dtype("location") is used.
]
#command("update", ..args("name", "value", ns:none))[
	Sets the option #arg[name] to #arg[value].
]
#command("update-all", ..args("values", ns:none))[
	Updates all key/value-pairs in the dictionary #arg[values]. Each key is used as the option name.
]
#command("remove", ..args("name", ns:none))[
	Remove the option #arg[name].
]
#command("display", ..args("name", format: "(v) => v", default:none, final:false, ns:none))[
	Show the value of option #arg[name] formated with the function #arg[format].

	If no such option exists, #arg[default] is used instead.

	#argument("format", type:"(any) => content", default:"(v) => v")[
		A function of one argument, that receives the optons value and transforms it into the content to be set.
	]
]

== Parsing arguments

#command("add-argument", ..args("name",
	type:     ("string", "content"),
	required: false,
	default:  none,
	choices:  none,
	store:    true,
	pipe:     none,
	code:     none))[

]
#command("parseconfig", ..args(_unknown:none, _opts:none), sarg("args"))[

]
#command("extract", ..args("var", _prefix:"", _positional:false), sarg("keys") )[

]

#command("getconfig", ..args("name", final:false))[

]

== Loading configuration files

#command("load", arg("filename"))[
	#argument("filename", type:("string", "dict"))[
		The file to load options from or a #dtype("dictionary") options. Supported are YAML, TOML and JSON files.
	]

	Loads options from a json, toml or yaml file.

	Any key on the girst level that has a #dtype("dict") as a value will be considered a namespace and the dictionary will be unpacked as options within this namespace.

	#sourcecode(title:"config.toml")[
	```toml
	[colors]
	red = 255,0,0
	green = 0,255,0
	blue = 0,0,255
	```
	]
	#sourcecode[
	```typc
	#options.load("config.toml")
	#text(
		fill:#options.get(
			"colors.red",
			v => rgb(..v.split(",")
		),
		[Hello World!]
	)
	```
	]

	#arg[filename] may be a prepopulated  #dtype("dict") to load in the same way described above.

	If you want to load a file without namespaces, just do something like this:

	#sourcecode[
	```typc
	#options.update-all(toml("config.toml"))
	```
	]
]

= Index

#make-index()

