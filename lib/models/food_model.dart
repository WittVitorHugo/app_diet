class FoodModel {
  String alimentoId;
  String descricao;
  String kcal;
  String proteina;
  String lipidio;
  String carboidrato;

  FoodModel({
    required this.alimentoId,
    required this.descricao,
    required this.kcal,
    required this.proteina,
    required this.lipidio,
    required this.carboidrato,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      alimentoId: json['alimento_id'], 
      descricao: json['descricao'], 
      kcal: json['kcal'], 
      proteina: json['proteina'], 
      lipidio: json['lipidio'], 
      carboidrato: json['carboidrato'], 
    );
  }

  Map toJson() => {
    "alimento_id": alimentoId,
    "descricao": descricao,
    "kcal": kcal,
    "proteina": proteina,
    "lipidio": lipidio,
    "carboidrato": carboidrato,
  };
}