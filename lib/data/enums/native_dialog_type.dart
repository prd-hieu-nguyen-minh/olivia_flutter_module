enum NativeDialogType {
  left,
  right,
  center;

  int get key {
    switch (this) {
      case NativeDialogType.left:
        return 1;
      case NativeDialogType.right:
        return 2;
      case NativeDialogType.center:
        return 3;
    }
  }
}
