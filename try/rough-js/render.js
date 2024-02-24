function init(id) {
    const canvas = document.getElementById(id);
    const context = canvas.getContext("2d");
    context.clearRect(0, 0, canvas.width, canvas.height);
    return rough.canvas(canvas);
}

##CODE##

rc.canvas.parentElement.style.display = "block";
