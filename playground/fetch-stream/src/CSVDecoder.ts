export class CSVDecoder {
  private onChunk: (data: string) => void = null!;
  public registerOnChunk(fn: (data: string) => void): void {
    this.onChunk = fn;
  }

  private partialChunk = '';

  decode(data: string) {
    const normalisedData = this.partialChunk + data;
    const chunks = normalisedData.split('\n');
    this.partialChunk = chunks.pop()!;
    chunks.forEach(this.onChunk);
  }


}

export class CSVDecoderStream implements ReadableWritablePair {
  readable: ReadableStream;
  writable: WritableStream;
  decoder = new CSVDecoder();


  constructor() {
    this.readable = new ReadableStream({
      start: (controller) => {
        this.decoder.registerOnChunk(chunk => controller.enqueue(chunk));
      }
    });

    this.writable = new WritableStream({
      write: (data) => {
        this.decoder.decode(data);
      }
    });

  }
}
