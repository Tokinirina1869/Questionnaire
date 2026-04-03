package com.monapp.repository;

import com.monapp.model.Etudiant;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class EtudiantRepository {
    @PersistenceContext(unitName = "app-questionnairePU")
    private EntityManager em;

    public void save(Etudiant e) 
    {
        em.persist(e);
    }

    public Etudiant find(String numEtudiant) 
    {
        return em.find(Etudiant.class, numEtudiant);
    }

    public List<Etudiant> findAll() 
    {
        return em.createQuery("SELECT e FROM etudiant e", Etudiant.class).getResultList();
    }

    public void delete(Etudiant e) 
    {
        em.remove(em.contains(e) ? e : em.merge(e));
    }
}
