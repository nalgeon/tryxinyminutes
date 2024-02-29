import io
import matplotlib.pyplot as plt


def show():
    plt.tight_layout()
    stream = io.StringIO()
    plt.savefig(stream, format="svg")
    print(stream.getvalue())


plt.show = show

##CODE##
