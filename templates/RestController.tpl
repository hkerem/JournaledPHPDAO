<?php
/**
 * Rest controller class for  '${idao_clazz_name}' DAO.
 *
 * @author: http://github.com/hkerem/JournaledPHPDAO
 * @date: ${date}
 */
class ${idao_clazz_name}Controller {

	/**
	 * Get Domain object by primary key
	 *
	 * @noAuth
	 * @url GET /${idao_clazz_name}/$id
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
	 * @noAuth
	 * @url DELETE /${idao_clazz_name}/$id
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
	 * @noAuth
	 * @url POST /${idao_clazz_name}
	 * @url PUT /${idao_clazz_name}/$id
 	 */
	public function save($id = null, $data){
		$transaction = new Transaction();
		if ($id == null) {
			DAOFactory::get${idao_clazz_name}DAO()->insert($data);
		} else {
			$data->id = $id;
			DAOFactory::get${idao_clazz_name}DAO()->update($data);
		}
		$transaction->commit();
		return $data;
	}

	/**
	 * List domain objects
	 *
	 * @noAuth
	 * @url GET /${idao_clazz_name}
	 */
	public function listAll(){
		$transaction = new Transaction();
		${queryByFieldControls}$arr = DAOFactory::get${idao_clazz_name}DAO()->queryAll();
		$transaction->commit();
		return $arr;
	}

}
?>
