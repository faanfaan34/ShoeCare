String fmtRp(int n) {
  final s = n.toString();
  final buf = StringBuffer('Rp ');
  final rem = s.length % 3;
  if (rem > 0) buf.write(s.substring(0, rem));
  for (int i = rem; i < s.length; i += 3) {
    if (i > 0 || rem > 0) buf.write('.');
    buf.write(s.substring(i, i + 3));
  }
  return buf.toString();
}

String starLabel(int stars) {
  const labels = ['', 'Buruk', 'Kurang', 'Cukup', 'Bagus', 'Sempurna!'];
  if (stars > 0 && stars <= 5) return labels[stars];
  return 'Sentuh bintang untuk menilai';
}