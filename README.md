# résumé

A collection of scripts and templates for automatically generating my résumé in a variety of formats. Data is stored in JSON and validates with the [JSON Resume Schema](http://jsonresume.org/ "JSON Resume") and templates make use of the [Liquid](https://github.com/Shopify/liquid "Liquid on GitHub") markup language. Output formats include: `.html`, `.md`, `.pdf`, `.txt`, and `.pdf`.

## Requirements

* [node.js](https://nodejs.org/en/ "Node.js")
  * `npm install -g resume-cli`
* [Ruby](https://www.ruby-lang.org/en/ "Ruby")
  * `gem install json`
  * `gem install liquid`
  * `gem install sass`
* [TeX (XeTeX)](https://www.latex-project.org/ "LaTeX")
* [Palatino Linotype](https://en.wikipedia.org/wiki/Palatino#Palatino_Linotype "Palatino Linotype Typeface") and [Roboto](https://www.google.com/fonts/specimen/Roboto "Roboto Font") fonts

## Usage

### Validating JSON

JSON data can be validated to check for formatting errors using the `resume-cli` command:

```sh
resume test resume.json
```

### Output

After cloning the repository the script will need to be made executable:

```sh
chmod +x generate.rb
```

The script takes no parameters and creates files in the `out/` directory which will automatically be created:

```sh
./generate.rb
```

## License

Personal data in [resume.json](resume.json) is copyrighted by [Mark Berger](http://maberger.com "Mark Berger's Website"). All other content is released under the [MIT License](http://www.opensource.org/licenses/MIT).
