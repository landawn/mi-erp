package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;

import net.mi.erp.entity.Project;

public interface ProjectDAO extends UncheckedCrudDao<Project, Integer, ProjectDAO> {

}
