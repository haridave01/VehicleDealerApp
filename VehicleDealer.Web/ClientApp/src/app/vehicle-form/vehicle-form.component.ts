import { Component, OnInit, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable } from 'rxjs';
import 'rxjs/add/Observable/forkJoin';
import { FeatureService } from '../../services/feature.service';
import { MakeService } from '../../services/make.service';
import { VehicleService } from '../../services/vehicle.service';
import { Notify } from '../shared/common/notify';
import { Utils } from '../shared/common/utils';

@Component({
    selector: 'app-vehicle-form',
    templateUrl: './vehicle-form.component.html',
    styleUrls: ['./vehicle-form.component.css']
})
export class VehicleFormComponent implements OnInit {
    @ViewChild('vehicleForm') vehicleFormRef: NgForm
    pendingRequest: Boolean = false

    makesList: Array<any> = []
    modelsList: Array<any> = []
    featuresList: Array<any> = []

    vehicle: any = {
        id: null,
        OwnersName: null,
        Manufacturer: null,
        Yearofmanufacture: null,
        manufacturersid : 0,
        categoriesid: 0,
        featuresIds: [],
        isRegistered: null
    }

    constructor(
        private _route: ActivatedRoute,
        private _router: Router,

        private _makeService: MakeService,
       
        private _vehicleService: VehicleService) {

        _route.params.subscribe(p => {
            this.vehicle.id = p['id']
        })
    }

    async ngOnInit() {
        try {
            var self = this
            var sources = [
                self._makeService.getMakesList(),
                
            ]

            if (!Utils.isNullOrEmpty(self.vehicle.id)) {
                sources.push(self._vehicleService.getVehicle(self.vehicle.id))
            }

            var responses = await Observable.forkJoin(sources).toPromise<any>()
            var [data1, data2, data3] = responses;

            if (data1 && data1.error === false) {
                var resources = data1.resources
                self.makesList = resources.itemsList
            }

            if (data2 && data2.error === false) {
                var resources = data2.resources
                self.featuresList = resources.itemsList
            }

            if (data3) {
                if (data3.error === false) {
                    self.setVehicle(data3)
                    self.populateModels()
                }
                else {
                    throw data3.errorMessage
                }
            }
        }
        catch (e) {
            self._router.navigate(['/not-found'])
        }
    }

    setVehicle(data) {
        var self = this
        var resources = data.resources

        self.vehicle.id = resources.id
        self.vehicle.OwnersName = resources.OwnersName
        self.vehicle.Manufacturer = resources.Manufacturer
        self.vehicle.Yearofmanufacture = resources.Yearofmanufacture
        self.vehicle.manufacturersid  = resources.make.id
        self.vehicle.categoriesid = resources.model.id
        
    }

    onMakeChange() {
        var self = this
        self.populateModels()
        self.vehicle.modelId = 0
    }

    populateModels() {
        var self = this
        var selectedMake = self.makesList.find(m => m.id === self.vehicle.makeId)
        self.modelsList = selectedMake ? selectedMake.models : []
    }

    onFeatureToggle(featureId, $event) {
        var self = this
        if ($event.target.checked) {
            self.vehicle.featuresIds.push(featureId)
        }
        else {
            var index = self.vehicle.featuresIds.indexOf(featureId)
            self.vehicle.featuresIds.splice(index, 1)
        }
    }

    isFeatureIncluded(featureId) {
        var self = this
        return self.vehicle.featuresIds.includes(featureId)
    }

    isNewVehicle() {
        var self = this
        return Utils.isNullOrEmpty(self.vehicle.id)
    }

    async submit($event) {
        try {
            var self = this
            self.pendingRequest = true

            $event.preventDefault()
            self.triggerValidations()
            if (self.vehicleFormRef.invalid) {
                return
            }

            var requestBody = {
                id: Utils.tryGet(() => self.vehicle.id),
                OwnersName: Utils.tryGet(() => self.vehicle.OwnersName),
                Manufacturer: Utils.tryGet(() => self.vehicle.Manufacturer),
                Yearofmanufacture: Utils.tryGet(() => self.vehicle.Yearofmanufacture),
                categoriesid: Utils.tryGet(() => self.vehicle.categoriesid),
                
            }

            var response = null
            if (self.vehicle.id) {
                response = await self._vehicleService
                    .updateVehicle(requestBody).toPromise<any>()
            }
            else {
                response = await self._vehicleService
                    .createVehicle(requestBody).toPromise<any>()
            }

            if (response?.error === false) {
                Notify.showSuccessNotification('The operation was completed successfully.')
                self._router.navigate(['/vehicles'])
            }
        }
        catch (e) { }
        finally {
            self.pendingRequest = false
        }
    }

    cancel() {
        var self = this
        self._router.navigate(['/vehicles'])
    }

    triggerValidations() {
        var self = this
        Object.keys(self.vehicleFormRef.controls)
            .forEach(field => {
                var control = self.vehicleFormRef.controls[field]
                control.markAsTouched({ onlySelf: true })
            })
    }
}

