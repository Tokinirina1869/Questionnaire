package com.monapp.service;

import com.monapp.model.Qcm;
import com.monapp.repository.QcmRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import java.util.List;

@Stateless
public class QcmService {

    @Inject
    private QcmRepository repoQcm;

    public void ajouterQcm(Qcm qcm) {
        if (qcm == null) {
            throw new IllegalArgumentException("QCM invalide");
        }
        repoQcm.save(qcm);
    }

    public List<Qcm> listerQcm() {
        return repoQcm.findAll();
    }

    public void modifierQcm(Qcm qcm) {
        if (qcm == null) {
            throw new IllegalArgumentException("QCM invalide");
        }
        repoQcm.update(qcm);
    }

    public void supprimerQcm(Long id) {
        repoQcm.delete(id);
    }
}