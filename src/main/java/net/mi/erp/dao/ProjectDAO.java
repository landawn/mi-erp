package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.query.SQLBuilder;

import net.mi.erp.entity.Project;

public interface ProjectDAO extends UncheckedCrudDao<Project, Long, SQLBuilder.PSC, ProjectDAO> {

}
