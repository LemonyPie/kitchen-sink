import { CSVDecoderStream } from "./CSVDecoder";
import { logReadableStream } from "./steam-helpers";

fetch('edu-scorecard.csv')
  .then((response) => response.body!
    .pipeThrough(new TextDecoderStream()))
  .then((text) => text
    .pipeThrough(new CSVDecoderStream()))
  .then(stream => stream.pipeTo(new WritableStream({
    write(data) {
      console.log(data);
    }
  })));
