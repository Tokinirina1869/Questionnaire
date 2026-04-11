package com.monapp.repository;

import com.monapp.model.Examen;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@ApplicationScoped
public class ExamenRepository {
    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void save(Examen exam)
    {
        em.persist(exam);
    }

    public List<Examen> findAll()
    {
        return em.createQuery("SELECT e FROM Examen e ORDER BY e.note DESC", Examen.class).getResultList();
    }
}
