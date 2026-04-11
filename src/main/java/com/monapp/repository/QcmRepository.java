package com.monapp.repository;

import com.monapp.model.Etudiant;
import com.monapp.model.Qcm;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class QcmRepository {
    
    @PersistenceContext
    private EntityManager em;

    public void save(Qcm qcm)
    {
        em.persist(qcm);
    }

    public List<Qcm> findAll()
    {
        return em.createQuery("SELECT q FROM Qcm q", Qcm.class).getResultList();
    }

    public List<Qcm> findRandom10() {
        return em.createNativeQuery("SELECT * FROM qcm ORDER BY RANDOM() LIMIT 10", Qcm.class)
                .getResultList(); 
    }

    public Qcm findById(Integer id)
    {
        return em.find(Qcm.class, id);
    }

    public Qcm update(Qcm qcm)
    {
        return em.merge(qcm);
    }

    public void delete(Integer id)
    {
        Qcm qcm = em.find(Qcm.class, id);
        if (qcm != null) {
            em.remove(qcm);
        }
    }

}
