const spec = `##CODE##`;

hashCode = function (s) {
    return s.split("").reduce(function (a, b) {
        a = (a << 5) - a + b.charCodeAt(0);
        return a & a;
    }, 0);
};

const diag = document.createElement("div");
diag.id = "mermaid-" + hashCode(spec);
diag.textContent = spec;

setTimeout(() => {
    mermaid.run({
        querySelector: `#${diag.id}`,
    });
}, 0);
return diag;
