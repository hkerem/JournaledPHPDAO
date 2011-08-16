<?php
/**
 * Rest controller class for  '${table_name}' DAO.
 *
 * @author: http://github.com/hkerem/JournaledPHPDAO
 * @date: ${date}
 */
class ${idao_clazz_name}Controller {

	/**
	 * Get Domain object by primary key
	 *
	 * @noauth
	 * @url GET /${table_name}/:id
	 */
	public function load($id){
		$transaction = new Transaction();
		$object = DAOFactory::get${idao_clazz_name}DAO()->load($id);
		$transaction->commit();
		return $object;
	}

	/**
	 * Delete Domain object by primary key
	 *
	 * @noauth
	 * @url DELETE /${table_name}/:id
	 */
	public function delete($id){
		$transaction = new Transaction();
		$ret = DAOFactory::get${idao_clazz_name}DAO()->delete($id);
		$transaction->commit();
		return $ret;
	}

	/**
 	 * Save object to database
 	 *
	 * @noauth
	 * @url POST /${table_name}
	 * @url PUT /${table_name}/:id
 	 */
	public function save($id = null, $object){
		$transaction = new Transaction();
		if ($id == null) {
			DAOFactory::get${idao_clazz_name}DAO()->insert($object);
		} else {
			$object->id = $id;
			DAOFactory::get${idao_clazz_name}DAO()->update($object);
		}
		$transaction->commit();
		return $object;
	}

	/**
	 * List domain objects
	 *
	 * @noauth
	 * @url GET /${table_name}/
	 * @url GET /${table_name}
	 */
	public function list(){
		$transaction = new Transaction();
		$arr = DAOFactory::get${idao_clazz_name}DAO()->queryAll();
		$transaction->commit();
		return $arr;
	}

}
?>
