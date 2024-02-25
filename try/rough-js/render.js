function init(id) {
    const canvas = document.getElementById(id);
    const context = scale(canvas, window.devicePixelRatio);
    context.clearRect(0, 0, canvas.width, canvas.height);
    return rough.canvas(canvas);
}

function scale(canvas, dpr) {
    if (canvas.hasAttribute("scaled")) {
        return canvas.getContext("2d");
    }
    canvas.width = canvas.width * dpr;
    canvas.height = canvas.height * dpr;
    canvas.style.width = canvas.width / dpr + "px";
    canvas.style.height = canvas.height / dpr + "px";
    const ctx = canvas.getContext("2d");
    ctx.scale(dpr, dpr);
    canvas.setAttribute("scaled", "");
    return ctx;
}

##CODE##

rc.canvas.parentElement.style.display = "block";
