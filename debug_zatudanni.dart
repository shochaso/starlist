import 'lib/src/services/youtube_ocr_parser_clean.dart';

void main() {
  print('=== Debug ZATUDANNI Test ===');
  const testCase = '''
加藤純一雑談ダイジェスト[2025/03/30]
ZATUDANNI
21万回視聴
''';
  
  // Split into lines to debug
  final lines = testCase.split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();
  
  print('Lines: $lines');
  
  // Check channel detection for each line
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    print('Line $i: "$line"');
    print('  Is channel: ${YouTubeOCRParser.isChannelName(line)}');
    print('  Is view count: ${YouTubeOCRParser.isViewCount(line)}');
  }
  
  // Test the block splitting
  final blocks = YouTubeOCRParser.splitIntoVideoBlocks(lines);
  print('\nBlocks: $blocks');
  
  // Test the full parser
  final videos = YouTubeOCRParser.parseOCRText(testCase);
  print('\nParsed videos:');
  for (var video in videos) {
    print('  Title: "${video.title}"');
    print('  Channel: "${video.channel}"');
    print('  Confidence: ${video.confidence}');
  }
}