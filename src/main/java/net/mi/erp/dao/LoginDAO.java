package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.jdbc.dao.UncheckedCrudJoinEntityHelper;

import net.mi.erp.entity.Login;

public interface LoginDAO
        extends UncheckedCrudDao<Login, Integer, LoginDAO>, UncheckedCrudJoinEntityHelper<Login, Integer, LoginDAO> {

}
