//TODO: Clean the Software Engineer.
class Job {
  final String company;
  final double companyScore;
  final String title;
  final String location;
  final String datePosted;    // optional, if you want to parse "8d", "2d"...
  final int avgSalary; //avgSalary is stored as a string, but we need to convert it to an int

  Job({
    required this.title,
    required this.company,
    required this.location,
    required this.avgSalary,
    required this.datePosted,
    required this.companyScore,
  });

  factory Job.fromMap(Map<String, String> row) {
    //.trim(): Removes any leading or trailing whitespace (spaces, tabs, newlines).
    final comp    = row['Company']!.trim(); //find the value under "company" column in our map. i.e "Spotify"
    final score   = double.tryParse(row['Company Score']!.trim()) ?? 0.0; //double.tryParse() attempts to convert the trimmed string into a double, if not work return 0.0
    final title   = row['Job Title']!.trim(); //find value under "Job Title" i.e "C# Software Engineer"
    final loc     = row['Location']!.trim(); //Find value under "location" i.e "Los Angles, CA"
    final posted = row['Date']!.trim();   //find value under "date" i.e "8d"
    final rawSal = row['Salary']!.trim();  //find the value under "salary" i.e "$68K - $94K (Glassdoor est.)" <--- we need to convert this string to an int later on



    final salRegex = RegExp(r'\$(\d+)K\s*-\s*\$(\d+)K'); //<-- literal moon runes
    // r'\$: find the first $ in the string, (\d+): gets first group of numbers
    final match    = salRegex.firstMatch(rawSal);
    if (match == null) {
      throw FormatException('Bad salary format: $rawSal');
    }
    final low  = int.parse(match.group(1)!) * 1000; //correct
    final high = int.parse(match.group(2)!) * 1000;
    final avg  = ((low + high) / 2).round();









    return Job(
      company: comp,
      companyScore: score,
      title: title,
      location: loc,
      datePosted: posted,
      avgSalary: avg,
    );
  }


}



