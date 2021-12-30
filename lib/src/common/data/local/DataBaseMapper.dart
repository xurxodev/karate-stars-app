abstract class DataBaseMapper<Entity, ModelDB> {
  Entity mapToDomain(ModelDB modelDB);

  ModelDB mapToDB(Entity entity);
}