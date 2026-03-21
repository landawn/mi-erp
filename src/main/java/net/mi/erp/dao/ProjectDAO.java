package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.query.SqlBuilder;

import net.mi.erp.entity.Project;

public interface ProjectDAO extends UncheckedCrudDao<Project, Integer, SqlBuilder.PSC, ProjectDAO> {

}
