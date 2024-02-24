---
x: Mermaid
title: Try Mermaid in Y minutes
image: /try/cover.png
lastmod: 2024-02-23
original: https://mermaid.js.org/intro/
license: MIT
contributors:
    - ["Mermaid team", "https://mermaid.js.org/"]
    - ["Anton Zhiyanov", "https://antonz.org"]
---

[Mermaid](https://mermaid.js.org/) lets you create diagrams and visualizations using text and code.

It is a JavaScript based diagramming and charting tool that renders Markdown-inspired text definitions to create and modify diagrams dynamically.

Let's see some of Mermaid's features in action! You can edit a diagram definition at any time and click the Run button to see the updated diagram.

[Flowchart](#flowchart) ·
[Sequence diagram](#sequence-diagram) ·
[Gantt chart](#gantt-chart) ·
[Class diagram](#class-diagram) ·
[Git graph](#git-graph) ·
[Entity relationship diagram](#entity-relationship-diagram) ·
[User journey diagram](#user-journey-diagram) ·
[Quadrant chart](#quadrant-chart) ·
[XY chart](#xy-chart) ·
[Further reading](#further-reading)

## Flowchart

A flowchart consists of nodes (geometric shapes) and edges (arrows or lines). It supports different arrow types, multidirectional arrows, and subgraphs.

```text
flowchart TD

A[Start]-->B[Step 1];
A-->C[Step 2];
B-->D[Done];
C-->D;
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

A more complex example with subgraphs:

```text
flowchart TB

c1-->a2
subgraph one
    a1-->a2
end
subgraph two
    b1-->b2
end
subgraph three
    c1-->c2
end
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

## Sequence diagram

A sequence diagram is an interaction diagram that shows how processes interact with each other and in what order.

```text
sequenceDiagram

Alice->>John: Hello John, how are you?
John-->>Alice: Great!
Alice-)John: See you later!
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

A more complex example with a loop and a note:

```text
sequenceDiagram

participant Alice
participant Bob

Alice->>John: Hello John, how are you?
loop Healthcheck
    John->>John: Fight against hypochondria
end
Note right of John: Rational thoughts <br/>prevail!
John-->>Alice: Great!
John->>Bob: How about you?
Bob-->>John: Jolly good!
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

## Gantt chart

A Gantt chart illustrates a project schedule and the time it will take to complete the project.

```text
gantt

title A Gantt Diagram
dateFormat YYYY-MM-DD

section Section
    A task          :a1, 2014-01-01, 30d
    Another task    :after a1, 20d
section Another
    Task in Another :2014-01-12, 12d
    another task    :24d
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

## Class diagram

A class diagram is the fundamental building block of object-oriented design. It is used to model the structure of an application. Class diagrams can also be used to model data.

```text
classDiagram

class Student {
    idCard: IdCard
}

class IdCard{
    id: int
    name: string
}

class Bike{
    id: int
    name: string
}

Student "1" --o "1" IdCard : carries
Student "1" --o "1" Bike : rides
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

A more complex example with inheritance and methods:

```text
classDiagram
note "From Duck till Zebra"

Animal <|-- Duck
note for Duck "can fly\ncan swim\ncan dive\ncan help in debugging"
Animal <|-- Fish
Animal <|-- Zebra

Animal: +int age
Animal: +String gender
Animal: +isMammal()
Animal: +mate()

class Duck{
    +String beakColor
    +swim()
    +quack()
}

class Fish{
    -int sizeInFeet
    -canEat()
}

class Zebra{
    +bool is_wild
    +run()
}
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

## Git graph

A git graph is a pictorial representation of git commits and git actions (commands) on different branches.

```text
gitGraph

commit
commit
branch develop
checkout develop
commit
commit
checkout main
merge develop
commit
commit
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

## Entity relationship diagram

An entity-relationship (ER) diagram describes interrelated things of interest in a particular domain of knowledge. A basic ER model consists of entity types (which classify the things of interest) and specifies relationships that can exist between entities (instances of those entity types).

```text
erDiagram

CUSTOMER ||--o{ ORDER : places
ORDER ||--|{ LINE-ITEM : contains
CUSTOMER }|..|{ DELIVERY-ADDRESS : uses
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

A more complex example with attributes:

```text
erDiagram

CUSTOMER {
    string name
    string custNumber
    string sector
}

ORDER {
    int orderNumber
    string deliveryAddress
}

LINE-ITEM {
    string productCode
    int quantity
    float pricePerUnit
}

CUSTOMER ||--o{ ORDER : places
ORDER ||--|{ LINE-ITEM : contains
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

## User journey diagram

A user journey describes the steps a user takes to complete a specific task within a system, application, or website.

```text
journey
title My working day

section Go to work
    Make tea: 5: Me
    Go upstairs: 3: Me
    Do work: 1: Me, Cat

section Go home
    Go downstairs: 5: Me
    Sit down: 5: Me
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

## Quadrant chart

A quadrant chart is a visual representation of data that is divided into four quadrants. Quadrant charts are often used to identify patterns and trends in data, and to prioritize actions based on the position of data points within the chart.

```text
quadrantChart
title Reach and engagement of campaigns

x-axis Low Reach --> High Reach
y-axis Low Engagement --> High Engagement

quadrant-1 We should expand
quadrant-2 Need to promote
quadrant-3 Re-evaluate
quadrant-4 May be improved

Campaign A: [0.3, 0.6]
Campaign B: [0.45, 0.23]
Campaign C: [0.57, 0.69]
Campaign D: [0.78, 0.34]
Campaign E: [0.40, 0.34]
Campaign F: [0.35, 0.78]
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

## XY chart

An XY chart includes several types of charts that use both the x-axis and the y-axis to display data. Currently, it includes two basic chart types: the bar chart and the line chart. These charts are designed to visually display and analyze data involving two numerical variables.

```text
xychart-beta
title "Sales Revenue"

x-axis [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec]
y-axis "Revenue (in $)" 4000 --> 11000

bar [5000, 6000, 7500, 8200, 9500, 10500, 11000, 10200, 9200, 8500, 7000, 6000]
line [5000, 6000, 7500, 8200, 9500, 10500, 11000, 10200, 9200, 8500, 7000, 6000]
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="dom">
</codapi-snippet>

## Further reading

Mermaid also supports other diagram types such as state diagrams, pie charts, mind maps, and timelines. See the [documentation](https://mermaid.js.org/intro/) for details.

See the [Getting started](https://mermaid.js.org/intro/getting-started.html) guide to start using Mermaid on your website or in your product.

<script defer src="https://cdn.jsdelivr.net/npm/mermaid@10.8.0/dist/mermaid.min.js"></script>
