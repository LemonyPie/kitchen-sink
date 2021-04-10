export function logReadableStream(name: string, rs: ReadableStream) {
  const [rs1, rs2] = rs.tee();

  rs2.pipeTo(new WritableStream({
    write(value) {
      console.warn(name, value);
    }
  })).catch(console.error);

  return rs1;
}
