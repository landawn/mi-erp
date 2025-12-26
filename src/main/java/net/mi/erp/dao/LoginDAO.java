package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.jdbc.dao.UncheckedCrudJoinEntityHelper;
import com.landawn.abacus.query.SQLBuilder;

import net.mi.erp.entity.Login;

public interface LoginDAO
        extends UncheckedCrudDao<Login, Integer, SQLBuilder.PSC, LoginDAO>, UncheckedCrudJoinEntityHelper<Login, Integer, SQLBuilder.PSC, LoginDAO> {

}
