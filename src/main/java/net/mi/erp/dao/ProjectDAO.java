package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.CrudDao;
import com.landawn.abacus.query.SQLBuilder;

import net.mi.erp.entity.Project;

public interface ProjectDAO extends CrudDao<Project, Integer, SQLBuilder.PSC, ProjectDAO> {

}
