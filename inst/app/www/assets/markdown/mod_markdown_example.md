## Markdown cheat sheet

### Basic syntax

These are the elements outlined in John Gruber's original design document. All Markdown applications support these elements.

#### Heading

# H1
## H2
### H3

#### Bold

Original markdown used the * character, but underscore can be used, and is what is used for the review scripts to work.

__bold text__

#### Italic

Original markdown used the * character, but underscore can be used, and is what is used for the review scripts to work.

_italicized text_

#### Blockquote

> blockquote

#### Ordered list

1. First item
2. Second item
3. Third item

#### Unordered list

- First item
- Second item
- Third item

#### Code

A single pair of backticks is generally used. But the review scripts require 4 pairs!

````code````

#### Horizontal rule

---

#### External link

[Markdown Guide](https://www.markdownguide.org)

#### Internal link

You can link to [another page](http://127.0.0.1/Another_markdown_page), and even a [specific heading](http://127.0.0.1/Another_markdown_page?linked-heading) on another page. The browser back button will also be enabled on doing this, to allow you to get back to where you were.

#### Image

Always specify the alt text. You can include images from web sources...

![alt text](https://cdn.ons.gov.uk/assets/images/ons-logo/v2/ons-logo.svg)

...and images served locally.

![alt text](www/assets/logos/nhs-logo.png)

### Extended syntax

These elements extend the basic syntax by adding additional features. Not all Markdown applications support these elements. Only the ones supported when using ````shiny::includeMarkdown```` are shown.

#### Table

| Syntax    | Description |
| ----------| ----------- |
| Header    | Title       |
| Paragraph | Text        |

#### Fenced code block

````
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}
````

#### Footnote

Here's a sentence with a footnote. [^1]

[^1]: This is the footnote.

#### Definition list

term
: definition

#### Strikethrough

~~The world is flat.~~

#### Task list

- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media

#### Subscript

H~2~O

#### Superscript

X^2^
