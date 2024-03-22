// PlantUML text encoding.

async function compressEncode(str) {
    const utf8 = new TextEncoder();
    const compressed = await compress(utf8.encode(str));
    return encode(new Uint8Array(compressed));
}

async function compress(data) {
    const cs = new CompressionStream("deflate-raw");
    const writer = cs.writable.getWriter();
    writer.write(data);
    writer.close();
    const compressedStream = new Response(cs.readable);
    const arrayBuffer = await compressedStream.arrayBuffer();
    return arrayBuffer;
}

function encode(data) {
    // see https://plantuml.com/text-encoding
    const mapping =
        "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_";

    let output = "";
    let temp = 0;
    let buffer = 0;
    let bitsCollected = 0;

    for (let i = 0; i < data.length; i++) {
        buffer = (buffer << 8) | data[i];
        bitsCollected += 8;
        while (bitsCollected >= 6) {
            bitsCollected -= 6;
            temp = buffer >> bitsCollected;
            output += mapping[temp & 63];
            buffer &= ~(63 << bitsCollected);
        }
    }

    if (bitsCollected > 0) {
        output += mapping[(buffer << (6 - bitsCollected)) & 63];
    }

    return output;
}

window.plantumlEncode = compressEncode;
export default { compressEncode };
