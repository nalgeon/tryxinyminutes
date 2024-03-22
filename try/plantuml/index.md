---
x: PlantUML
title: Try PlantUML in Y minutes
image: /try/cover.png
lastmod: 2024-03-22
license: CC-BY-SA-4.0
contributors:
    - ["Anton Zhiyanov", "https://antonz.org"]
---

<script id="main.js" type="text/plain">
    const spec = `##CODE##`;
    const encoded = await plantumlEncode(spec);
    const resp = await fetch(`https://www.plantuml.com/plantuml/svg/${encoded}`);
    return await resp.text();
</script>

[PlantUML](https://plantuml.com/) lets you create diagrams from a plain text language.

```text
@startuml
Bob -> Alice : hello
@enduml
```

<codapi-snippet engine="browser" sandbox="javascript" command="run" editor="basic"  template="#main.js" output-mode="svg">
</codapi-snippet>

<script type="module" src="plantuml.js"></script>
