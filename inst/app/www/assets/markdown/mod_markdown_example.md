## Markdown cheat sheet

The markdown syntax compatible with the review automation scripts is shown below. There exists further markdown syntax that could be incorporated if required.

---

### Heading

```
# H1
## H2
### H3
#### H4
```

# H1
## H2
### H3
#### H4

---

### Bold

Original markdown used double * characters, but underscore can be used, and is what is used for the review scripts to work.

```
__bold text__
```

__bold text__

---

### Italic

Original markdown used the * character, but underscore can be used, and is what is used for the review scripts to work.

```
_italicized text_
```

_italicized text_

---

### Ordered list

```
1. First item
2. Second item
3. Third item
```

1. First item
2. Second item
3. Third item

---

### Unordered list

```
- First item
- Second item
- Third item
```

- First item
- Second item
- Third item

---

### Inline code

```
Here is some inline ````code````. Note it uses four pairs of backticks, not a single pair as usual for markdown!
```

Here is some inline `code`.

---

### External link

```
[Markdown Guide](https://www.markdownguide.org)
```

[Markdown Guide](https://www.markdownguide.org)

---

### Internal link

You can link to another page using the `localhost` IP address and pointing to a page by using the `title` of its `tabpanel`, as defined in `app_ui.R`, with any spaces replaced by underscores.

```
[Link to page "Another markdown page"](http://127.0.0.1/Another_markdown_page)
```

[Link to page "Another markdown page"](http://127.0.0.1/Another_markdown_page)

You can even link to a specific heading on another page. Just add a `?` followed by a string formed from the lower case heading text, with non-alphanumeric characters removed and spaces replaced with dashes.

```
[Link to heading "Linked heading"on page "Another markdown page"](http://127.0.0.1/Another_markdown_page?linked-heading)
```

[Link to heading "Linked heading" on page "Another markdown page"](http://127.0.0.1/Another_markdown_page?linked-heading)

The browser back button will also be enabled after using an internal link, to allow you to get back to where you were.

### Inline code with link

Links can be created on inline code using

```
[````{nhsbsaShinyR}````](https://github.com/nhsbsa-data-analytics/nhsbsaShinyR)
```

[````{nhsbsaShinyR}````](https://github.com/nhsbsa-data-analytics/nhsbsaShinyR)

Note the braces (`{}`) are not necessary, but are a convention when writing an R package name.
