import 'dart:math';

Map<String, dynamic>? findMostSimilarStudent(
  List<Map<String, dynamic>> students,
  List<double> targetEmbedding, {
  double thresholdLow = 0.50,
}) {
  if (students.isEmpty) return null;

  double cosineSimilarity(List<double> a, List<double> b) {
    double dot = 0.0;
    double normA = 0.0;
    double normB = 0.0;

    for (int i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }

    return dot / (sqrt(normA) * sqrt(normB));
  }

  Map<String, dynamic>? bestStudent;
  double bestScore = double.negativeInfinity;

  for (var student in students) {
    var emb = student['embedding'];
    if (emb == null) continue;

    List<double> embList = List<double>.from(emb);

    if (embList.length != targetEmbedding.length) continue;

    double score = cosineSimilarity(targetEmbedding, embList);

    if (score > bestScore) {
      bestScore = score;
      bestStudent = student;
    }
  }

  if (bestScore < thresholdLow) {
    return null;
  }

  return bestStudent;
}
