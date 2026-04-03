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

    //CREATE
    public void save(Etudiant e) 
    {
        em.persist(e);
    }
    
    // READ (Unique)
    public Etudiant find(String numEtudiant) 
    {
        return em.find(Etudiant.class, numEtudiant);
    }

    // READ (Tous)
    public List<Etudiant> findAll() 
    {
        return em.createQuery("SELECT e FROM Etudiant e", Etudiant.class).getResultList();
    }

    public Etudiant update(Etudiant e)
    {
        return em.merge(e);  
    }

    public void delete(Etudiant etu) 
    {
        Etudiant e = find(etu.getNumEtudiant());
        if (e != null) {
            em.remove(e);
        }
    }
}
