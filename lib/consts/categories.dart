class Category {
  final int id;
  final String title;
  final String description;
  final String photoUrl;

  Category({
    required this.id,
    required this.title,
    required this.description,
    required this.photoUrl,
  });
}

List<Category> categories = [
  Category(
    id: 1,
    title: "Assistência Técnica",
    description:
        "Encontre assistência de celular, computador, notebook, impressora, geladeira, eletrodomésticos em autorizadas de diversas marcas. Profissionais em Assistência Técnicas",
    photoUrl: 'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png',
  ),
  Category(
    id: 2,
    title: "Serviços Domésticos",
    description:
        "Encontre aqui profissionais especializados em diversos tipos de serviços para sua casa e animais de estimação,Profissionais em Serviços Domésticos.",
    photoUrl: 'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png',
  ),
  Category(
    id: 3,
    title: "Reformas",
    description:
        "Encontre aqui pedreiros, encantadores, marceneiros, arquitetos, marido de aluguel, dedetizadores e outros. Profissionais em Reformas e Construção.",
    photoUrl: 'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png',
  ),
];
