import 'datum.dart';
import 'metadata.dart';

class CategoryModel {
	int? results;
	Metadata? metadata;
	List<Datum>? data;

	CategoryModel({this.results, this.metadata, this.data});

	factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
				results: json['results'] as int?,
				metadata: json['metadata'] == null
						? null
						: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
				data: (json['data'] as List<dynamic>?)
						?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'results': results,
				'metadata': metadata?.toJson(),
				'data': data?.map((e) => e.toJson()).toList(),
			};
}
