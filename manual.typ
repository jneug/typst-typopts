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
	version:	"0.0.3",
	date:		"2023-07-05",
	abstract: 	[
		#pkg[typopts] is a *Typst* package with the intend to make handling options for packages and templates as easy as possible.

		It provides functionality to load options from various sources, merge them together and make them accessible throughout the document.
	]
)

= About

#name was inspired by _LaTeX_ packages like #mty.rawi[pgfkeys]#footnote[https://ctan.org/pkg/pgfkeys] and modules like #mty.rawi[argparse]#footnote[https://docs.python.org/3/library/argparse.html] in _Python_.

= Usage

== Use as a module

To use Typopts as a module for one project, get the file `options.typ` from the repository and save it in your project folder.

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
git clone https://github.com/jneug/typst-typopts.git typopts-0.0.3
```
]

In either case make sure the files are placed in a folder with the correct version number: `typopts-0.0.3`

After installing the package just import it inside your `typ` file:

#sourcecode[
```typc
#import "@local/typopts:0.0.3": options
```
]

== Available functions

Typopts provides you with several commands in three categories: Options access, argument parsing and configuration loading.

=== Accessing options

#command("get", "name", "func", default:none, final:false, loc:none)[
	#argument("name", type:"string")[
		Name of the option.
	]
	#place(right, dtype("v => v"))#arg("func"): Function to pass the value to.

	Retrieves the value for the option by the given #arg("name") and passes it to #arg("func"), which is a function of on argument.

	If no option #arg("name") exists, the given #arg("default") is passed on.

	If #arg(final: true), the final value for the option is retrieved, otherwise the current value. If #arg("loc") is given, the call is not wrapped inside a #doc("meta/locate") call and the given #dtype("location") is used.
]
#command("update", "name", "value")[
	Updates an option
]

== Parsing arguments

#options.load("typst.toml")


== Loading configuration files

