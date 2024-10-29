enum SizeTypes {
  XSmall,
  Small,
  Medium,
  Large,
  XLarge,
  XXLarge,
  XXXLarge,
}

String getSizeShortcut(String size) {
  switch (size) {
    case 'XSmall':
      return 'XS';
    case 'Small':
      return 'S';
    case 'Medium':
      return 'M';
    case 'Large':
      return 'L';
    case 'XLarge':
      return 'XL';
    case 'XXLarge':
      return 'XXL';
    case 'XXXLarge':
      return 'XXXL';
    default:
      return 'Unknown';
  }
}
