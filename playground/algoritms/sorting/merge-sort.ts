// export function merge(left: number[], right: number[]): number[] {
//   let result = [];
//   while (left.length > 0 && right.length > 0) {
//     if (left[0] < right[0]) {
//       result.push(left.shift());
//     } else {
//       result.push(right.shift())
//     }
//   }
//   return [...result, ...left, ...right];
// }
function compare(a: number, b: number): boolean {
  return a < b;
}

export function merge(left: number[], right: number[]): number[] {
  let result = [];
  let l = 0; let r = 0;
  for (let i = 0; i < left.length + right.length; i++) {
    if (compare(left[l], right[r]) || right[r] === undefined) {
      result.push(left[l++]);
    } else {
      result.push(right[r++]);
    }
  }
  return result;
}

export function mergeSort(array: number[]): number[] {
  if (array.length === 0 || array.length === 1) {
    return array;
  }

  const leftHalf = array.slice(0, array.length / 2);
  const rightHalf = array.slice(leftHalf.length);
  return merge(
    mergeSort(leftHalf),
    mergeSort(rightHalf)
  );
}

const input = [9, 2, 3, 8, 1, 4, 7, 6, 10];
mergeSort(input); //?




