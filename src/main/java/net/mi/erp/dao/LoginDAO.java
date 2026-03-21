package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.jdbc.dao.UncheckedCrudJoinEntityHelper;
import com.landawn.abacus.query.SqlBuilder;

import net.mi.erp.entity.Login;

public interface LoginDAO
        extends UncheckedCrudDao<Login, Integer, SqlBuilder.PSC, LoginDAO>, UncheckedCrudJoinEntityHelper<Login, Integer, SqlBuilder.PSC, LoginDAO> {

}
