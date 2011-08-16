<?php
/**
 * Class that operate on table '${table_name}'. Database Mysql.
 *
 * @author: http://phpdao.com
 * @date: ${date}
 */
class ${dao_clazz_name}DAO implements ${idao_clazz_name}DAO{

	/**
	 * Get Domain object by primry key
	 *
	 * @param String $id primary key
	 * @return ${dao_clazz_name} 
	 */
	public function load($id){
		$sql = 'SELECT * FROM ${table_name} WHERE ${pk} = ? AND is_deleted = FALSE';
		$sqlQuery = new SqlQuery($sql);
		$sqlQuery->set${pk_number}($id);
		return $this->getRow($sqlQuery);
	}

	/**
	 * Get all records from table
	 */
	public function queryAll(){
		$sql = 'SELECT * FROM ${table_name} WHERE is_deleted = FALSE';
		$sqlQuery = new SqlQuery($sql);
		return $this->getList($sqlQuery);
	}
	
	/**
	 * Get all records from table ordered by field
	 *
	 * @param $orderColumn column name
	 */
	public function queryAllOrderBy($orderColumn){
		$sql = 'SELECT * FROM ${table_name} WHERE is_deleted = FALSE ORDER BY '.$orderColumn;
		$sqlQuery = new SqlQuery($sql);
		return $this->getList($sqlQuery);
	}
	
	/**
 	 * Delete record from table
 	 * @param ${var_name} primary key
 	 */
	public function delete($${pk}){
		$sql = 'UPDATE ${table_name} SET is_deleted = TRUE, delete_epoch=unix_timestamp(now()) WHERE ${pk} = ? AND is_deleted = FALSE';
		$sqlQuery = new SqlQuery($sql);
		$sqlQuery->set${pk_number}($${pk});
		return $this->executeUpdate($sqlQuery);
	}
	
	/**
 	 * Insert record to table
 	 *
 	 * @param ${dao_clazz_name} ${var_name}
 	 */
	public function insert($${var_name}){
		$isql = 'SELECT MAX(${pk}) FROM ${table_name}';
		$isqlQuery = new SqlQuery($isql);
		$last_pk = $this->getSingleValue($isqlQuery);
		if ($last_pk == NULL)
			$next_pk = 1;
		else
			$next_pk = $last_pk + 1;

		$sql = 'INSERT INTO ${table_name} (${pk},${insert_fields},is_deleted,create_epoch) VALUES (?,${question_marks},FALSE,unix_timestamp(now()))';
		$sqlQuery = new SqlQuery($sql);
		$sqlQuery->set${pk_number}($next_pk);
		${parameter_setter}
		$this->executeInsert($sqlQuery);	

		$${var_name}->${pk_php} = $next_pk;
		return $next_pk;
	}
	
	/**
 	 * Update record in table
 	 *
 	 * @param ${dao_clazz_name} ${var_name}
 	 */
	public function update($${var_name}){
		$usql = 'UPDATE ${table_name} SET is_deleted = TRUE, delete_epoch=unix_timestamp(now()) WHERE ${pk} = ? AND is_deleted = FALSE';
		$usqlQuery = new SqlQuery($usql);
		$usqlQuery->set${pk_number}($${var_name}->${pk_php});
		$ret = $this->executeUpdate($usqlQuery);

		$sql = 'INSERT INTO ${table_name} (${pk},${insert_fields},is_deleted,create_epoch) VALUES (?,${question_marks},FALSE,unix_timestamp(now()))';
		$sqlQuery = new SqlQuery($sql);
		$sqlQuery->set${pk_number}($${var_name}->${pk_php});
		${parameter_setter}
		$this->executeInsert($sqlQuery);	

		return $ret;
	}

	/**
 	 * Delete all rows
 	 */
	public function clean(){
		$sql = 'UPDATE ${table_name} SET is_deleted = TRUE, delete_epoch=unix_timestamp(now()) WHERE is_deleted = FALSE';
		$sqlQuery = new SqlQuery($sql);
		return $this->executeUpdate($sqlQuery);
	}

${queryByFieldFunctions}
${deleteByFieldFunctions}
	
	/**
	 * Read row
	 *
	 * @return ${dao_clazz_name} 
	 */
	protected function readRow($row){
		$${var_name} = new ${domain_clazz_name}();
		${read_row}
		return $${var_name};
	}
	
	protected function getList($sqlQuery){
		$tab = QueryExecutor::execute($sqlQuery);
		$ret = array();
		for($i=0;$i<count($tab);$i++){
			$ret[$i] = $this->readRow($tab[$i]);
		}
		return $ret;
	}

	
	/**
	 * Get row
	 *
	 * @return ${dao_clazz_name} 
	 */
	protected function getRow($sqlQuery){
		$tab = QueryExecutor::execute($sqlQuery);
		if(count($tab)==0){
			return null;
		}
		return $this->readRow($tab[0]);		
	}

	/**
	 * Get single value
	 *
	 * @return ${dao_clazz_name} 
	 */
	protected function getSingleValue($sqlQuery){
		$tab = QueryExecutor::execute($sqlQuery);
		if(count($tab)==1 && count($tab[0])==2){
			return $tab[0][0];
		} else {
			Throw new Exception("Should return one row with one field, Anything else is forbidden!");
		}
		return $this->readRow($tab[0]);		
	}
	
	/**
	 * Execute sql query
	 */
	protected function execute($sqlQuery){
		return QueryExecutor::execute($sqlQuery);
	}
	
		
	/**
	 * Execute sql query
	 */
	protected function executeUpdate($sqlQuery){
		return QueryExecutor::executeUpdate($sqlQuery);
	}

	/**
	 * Query for one row and one column
	 */
	protected function querySingleResult($sqlQuery){
		return QueryExecutor::queryForString($sqlQuery);
	}

	/**
	 * Insert row to table
	 */
	protected function executeInsert($sqlQuery){
		return QueryExecutor::executeInsert($sqlQuery);
	}
}
?>
